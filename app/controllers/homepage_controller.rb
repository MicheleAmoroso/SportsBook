class HomepageController < ApplicationController

  before_action :authenticate_user!
  
  def index
    
  end

  def show
    redirect_to "grounds#index"
  end
end
