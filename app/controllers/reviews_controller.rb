class ReviewsController < ApplicationController

  
  def new
    
  end

  def create
    ground_id = params[:ground_id]
    user_id = current_user.id
    @ground = Ground.find(ground_id)
    @review = Review.new(:rating => params[:rating], :comments => params[:review])
    @review.user_id = user_id
    @review.ground_id = ground_id
    @review.save!
    redirect_to ground_path(@ground)
  end
end
