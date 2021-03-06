# coding: utf-8
class GroundsController < ApplicationController


  def index
    grounds = Ground.all
    if "#{params[:search]}" != ""
      grounds = grounds.where(["title LIKE ?","%#{params[:search]}%"])
    end
    if "#{params[:priceFrom]}" != ""
      grounds = grounds.where(["price >= ?", "#{params[:priceFrom]}".to_i])
    end
    if "#{params[:priceTo]}" != ""
      grounds = grounds.where(["price <= ?", "#{params[:priceTo]}".to_i])
    end
    if "#{params[:category]}" != "Qualsiasi"
      grounds = grounds.where(["category LIKE ?", "%#{params[:category]}%"])
    end
    @grounds = grounds
  end

  def show
    id = params[:id]
    @ground = Ground.find(id)

    @books = Book.all

    reviews = Review.all
    reviews = reviews.where(["ground_id LIKE ?", "#{params[:id]}"])
    @reviews = reviews
  end

  def new
    
  end
  
  def create
    @control_flag = false
    flash[:notice] = ""
    if (params[:title] == "")
      flash[:notice] += "• Il campo nome non può essere vuoto | "
      @control_flag = true
    end
    if (params[:price1] == "") && (params[:price2] == "")
      flash[:notice] += "• Non possono essere vuoti tutti e due i campi del prezzo | "
      @control_flag = true
    end
    if (params[:price1].to_i.to_s != params[:price1]) || (params[:price2].to_i.to_s != params[:price2]) #Questo metodo serve per verificare che i prezzi siano numero ma non è molto bello a vedersi
      flash[:notice] += "• I prezzi devono essere numeri | "
      @control_flag = true
    end
    if (params[:city] == "")
      flash[:notice] += "• Il campo città non può essere vuoto | "
      @control_flag = true
    end
    if (params[:address] == "")
      flash[:notice] += "• Il campo indirizzo non può essere vuoto | "
      @control_flag = true
    end
    if @control_flag
      redirect_to new_ground_path
    else
    
      if (current_user.has_role? :proprietor) || (current_user.has_role? :admin) #Possono creare nuovi campo i proprietor e l'admin, non i player
        price = params[:price1].to_f + (params[:price2].to_f/100)
        @ground = Ground.create!(:title => params[:title], :price => price, :city => params[:city], :address => params[:address], :description => params[:description], :category => params[:category])
        if params[:ground_image] != nil
          @ground.ground_image.attach(params[:ground_image])
        else
          @ground.ground_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.jpg")), filename: 'default.jpg' , content_type: "image/jpg")
        end
        @ground.save!
        current_user.add_role :owner, @ground #Serve per associare il campo al proprietario, per evitare che un altro utente elimini un campo non suo
        redirect_to ground_path(@ground)
      else
        flash[:notice] = "Non ti è permesso creare campi sportivi!"
        redirect_to root_path
      end
      
    end
  end

  def edit
    
  end

  def update
    if (current_user.has_role? :proprietor) || (current_user.has_role? :admin) #Possono modificare i campi i proprietor e l'admin, non i player
      @ground = Ground.find(params[:id])
      if (current_user.has_role? :owner, @ground) || (current_user.has_role? :admin) #Il proprietor può modificare il campo sportivo solo se è suo
        if params[:price1] != "" || params[:price1] != ""
          price = params[:price1].to_f + (params[:price2].to_f/100)
          @ground.price = price
        end
        if params[:title] != ""
          @ground.title = params[:title]
        end
        if params[:city] != ""
          @ground.city = params[:city]
        end
        if params[:description] != ""
          @ground.description = params[:description]
        end
        if params[:category] != ""
          @ground.category = params[:category]
        end
        if params[:address] != ""
          @ground.address = params[:address]
        end
        if params[:ground_image] != nil
          @ground.ground_image.attach(params[:ground_image])
        end
        @ground.save!
        redirect_to ground_path(@ground)
      else
        flash[:notice] = "Non ti è permesso modificare campi sportivi degli altri!"
      redirect_to root_path
      end
    else
      flash[:notice] = "Non ti è permesso modificare campi sportivi!"
      redirect_to root_path
    end
  end

  def destroy
    id_ground = params[:id]
    @ground = Ground.find(id_ground)
    if (current_user.has_role? :owner, @ground) || (current_user.has_role? :admin) #Se l'utente è il possessore del campo allora può eliminarlo
      books = Book.with_role(:owner, current_user).where(:ground_id => id_ground)
      books.each do |book|
        Timetable.all.where(:id => book.timetable_id).destroy_all
        book.destroy #Elimino tutte le prenotazioni di quel campo
      end
      @ground.reviews.destroy_all #Elimino tutte le recensioni di quel campo
      @ground.favorites.destroy_all #Elimino tutte le preferenze di quel campo
      @ground.destroy
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "Non puoi eliminare i campi degli altri!"
      redirect_to root_path
    end
  end

end
