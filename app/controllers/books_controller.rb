# coding: utf-8
class BooksController < ApplicationController

  def index
    
  end
  
  def create
    
  end

  def update
    if params[:book_action] == "add" #Caso in cui voglio aggiungere una prenotazione
      if (current_user.has_role? :proprietor)
        flash[:notice] = "Non puoi prenotare i campi sportivi."
        redirect_to ground_path(params[:ground_id])
      else
        ground_id = params[:ground_id]
        user_id = current_user.id
        timetable_id = params[:timetable_id]
        b = Book.all.where(:ground_id => ground_id, :timetable_id => timetable_id).first
        b.user_id = user_id
        b.save!
        current_user.add_role :booker, b #Assegno all'utente che prenota il ruolo di booker di quel book
        redirect_to ground_path(ground_id)
      end
    elsif params[:book_action] == "remove" #Se voglio eliminarla
      if (current_user.has_role? :proprietor)
        flash[:notice] = "Non puoi eliminare le prenotazioni dei campi sportivi."
        redirect_to ground_path(Book.find(params[:id]).ground_id)
      else
        id = params[:id]
        @book = Book.find(id)
        if (current_user.has_role? :booker, @book) #Se l'utente è l'effettivo prenotatore può eliminare la propria prenotazione
          @book.user_id = nil
          @book.save!
          redirect_to user_path(current_user.id)
        else
          flash[:notice] = "Non puoi eliminare le prenotazioni degli altri!"
          redirect_to ground_path(@book.ground_id)
        end
      end
    end
  end
  
end
