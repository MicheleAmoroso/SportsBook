class BooksController < ApplicationController

  def index
    
  end
  
  def create
    ground_id = params[:ground_id]
    user_id = current_user.id
    timetable_id = params[:timetable_id]
    b = Book.all.where(:ground_id => ground_id, :timetable_id => timetable_id).first
    b.user_id = user_id
    b.save!
    redirect_to ground_path(ground_id)
  end
  
end
