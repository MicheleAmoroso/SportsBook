class HomepageController < ApplicationController

  
  def index
    
  end

  def show
    redirect_to "grounds#index"
  end
end
