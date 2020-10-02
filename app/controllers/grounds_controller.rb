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
    if (current_user.has_role? :proprietor) || (current_user.has_role? :admin) #Possono creare nuovi campo i proprietor e l'admin, non i player
      price = params[:price1].to_f + (params[:price2].to_f/100)
      @ground = Ground.create!(:title => params[:title], :price => price, :city => params[:city], :address => params[:address], :description => params[:description], :category => params[:category])
      @ground.ground_image.attach(params[:ground_image])
      @ground.save!
      current_user.add_role :owner, @ground #Serve per associare il campo al proprietario, per evitare che un altro utente elimini un campo non suo
      redirect_to ground_path(@ground)
    else
      flash[:notice] = "Non ti è permesso creare campi sportivi!"
      redirect_to root_path
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
      @ground.destroy
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "Non puoi eliminare i campi degli altri!"
      redirect_to root_path
    end
  end

end
