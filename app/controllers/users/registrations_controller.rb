class Users::RegistrationsController < Devise::RegistrationsController


  def create
    super

    

    if current_user
      if params[:role] == "player"
        current_user.add_role :player
      elsif params[:role] == "proprietor"
        current_user.add_role :proprietor
      end
    end
  end

  
  def destroy
    @reviews = Review.all.where(:user_id => current_user.id)
    @reviews.each do |review|
      @ground = Ground.find(review.ground_id)
      @ground.ratingNum = @ground.ratingNum - 1
      @ground.ratingSum = @ground.ratingSum - review.rating
      @ground.save!
    end
    @reviews.destroy_all

    @books = Book.all.where(:user_id => current_user.id)
    @books.each do |book|
      book.user_id = nil
      book.save!
    end

    if current_user.has_role? :proprietor
      grounds = Ground.with_role(:owner, current_user) #Prendo tutti i ground dell'utente che si vuole cancellare
      grounds.each do |ground| #Per ognuno di essi
        books = Book.with_role(:owner, current_user).where(:ground_id => ground.id) #Prendo tutte le sue prenotazioni
        books.each do |book| #Per ognuna di esse
          Timetable.all.where(:id => book.timetable_id).destroy_all #Ne elimino il timatable
          book.destroy #Elimino tutte le prenotazioni del proprietario
        end
        ground.destroy #Elimino tutti i grounds del proprietario
      end
    end
    
    super
  end

end
