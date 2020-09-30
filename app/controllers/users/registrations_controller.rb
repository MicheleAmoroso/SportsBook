class Users::RegistrationsController < Devise::RegistrationsController
  
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

    super
  end
  
end
