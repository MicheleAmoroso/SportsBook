# coding: utf-8
class ReviewsController < ApplicationController

  
  def new
    
  end

  def create
    ground_id = params[:ground_id]
    user_id = current_user.id
    @ground = Ground.find(ground_id)
    if (current_user.has_role? :player) || (current_user.has_role? :admin) #Possono scrivere recensioni i player e l'admin, non i proprietari
      @review = Review.new(:rating => params[:rating], :comments => params[:review])
      @review.user_id = user_id
      @review.ground_id = ground_id
      @review.save!
      current_user.add_role :writer, @review #Serve per associare il commento allo scrittore, per evitare che un altro utente elimini una recensione non sua
      @ground.ratingNum = @ground.ratingNum + 1
      @ground.ratingSum = @ground.ratingSum + params[:rating].to_i
      @ground.save!
      redirect_to ground_path(@ground)
    else
      flash[:notice] = "Non ti è permesso scrivere recensioni!"
      redirect_to ground_path(@ground)
    end
  end

  def destroy
    id = params[:id]
    id_ground = params[:ground_id]
    @ground = Ground.find(id_ground)
    @review = Review.find(id)
    if (current_user.has_role? :writer, @review) || (current_user.has_role? :admin) #Se l'utente è lo scrittore del commento allora può eliminarlo
      @review.destroy
      @ground.ratingNum = @ground.ratingNum - 1
      @ground.ratingSum = @ground.ratingSum - @review.rating.to_i
      @ground.save!
      redirect_to ground_path(id_ground)
    else
      flash[:notice] = "Non puoi eliminare le recensioni degli altri!"
      redirect_to ground_path(@ground)
    end
  end
  
end
