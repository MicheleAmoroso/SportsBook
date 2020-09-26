class SessionController < ApplicationController
  skip_before_action :set_current_user
  
  def login

  end

  def create
    name = params[:username]
    session[:user_id] = User.all.where(:name => params[:username]).ids.first
    @user = User.where(:name => name)
    if @user.length>0
      redirect_to root_path
    else
      redirect_to login_path
    end

    def destroy
      session.delete(:user_id)
    end
  end
  
end
