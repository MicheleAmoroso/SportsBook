class UsersController < ApplicationController

  def index
    
  end
  
  def show
    @current_user = User.all.where(["id LIKE ?", "#{current_user.id}"]).first
  end

  def edit
    
  end
  
end
