class FavoritesController < ApplicationController

  def create
    ground_id = params[:ground_id]
    user_id = current_user.id
    @ground = Ground.find(ground_id)
    @favorite = Favorite.new()
    @favorite.user_id = user_id
    @favorite.ground_id = ground_id
    @favorite.save!
    redirect_to grounds_path
  end

  def destroy
    id = params[:id]
    id_ground = params[:ground_id]
    @ground = Ground.find(id_ground)
    @favorite = Favorite.find(id)
    @favorite.destroy
    flash[:notice] = "Your review has been deleted."
    redirect_to grounds_path
  end
  
end
