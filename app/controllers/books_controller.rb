# coding: utf-8
class BooksController < ApplicationController

  def index
    
  end

  def new
    
  end
  
  def create
    @control_flag = false

    flash[:notice] = ""
    
    if (params[:from] == "") || (params[:to] == "")
      flash[:notice] += "• L'orario deve essere completo | "
      @control_flag = true
    end
    if (params[:from].to_i.to_s != params[:from]) || (params[:to].to_i.to_s != params[:to]) #Questo metodo serve per verificare che i prezzi siano numero ma non è molto bello a vedersi
      flash[:notice] += "• Gli orari devono essere numeri | "
      @control_flag = true
    elsif (params[:from].to_i > params[:to].to_i) || (params[:from].to_i < 0) || (params[:to].to_i > 24)
      flash[:notice] += "• Il formato dell'orario è sbagliato | "
      @control_flag = true
    end
    if @control_flag
      redirect_to new_ground_book_path(params[:ground_id])
    else
    
      if (current_user.has_role? :player)
        flash[:notice] = "Non hai il permesso di creare prenotazioni."
        redirect_to root_path
      else
        ground_id = params[:ground_id]
        @ground = Ground.find(ground_id)
        if (current_user.has_role? :owner, @ground) || (current_user.has_role? :admin)
          b = Book.new()
          g = Ground.all.where(:id => ground_id).first
          t = Timetable.create!(:day => params[:day], :from => params[:from], :to => params[:to])
          g.books << b
          t.books << b
          b.save!
          current_user.add_role :owner, b #Assegno all'utente che crea la prenotazione il ruolo di possessore della prenotazione stessa
          redirect_to user_path(current_user.id)
        else
          flash[:notice] = "Non puoi creare le prenotazioni agli altri."
          redirect_to root_path
        end
      end
      
    end
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
        redirect_to root_path
      else
        id = params[:id]
        @book = Book.find(id)
        if (current_user.has_role? :booker, @book) || (current_user.has_role? :admin) #Se l'utente è l'effettivo prenotatore può eliminare la propria prenotazione
          @book.user_id = nil
          @book.save!
          redirect_to user_path(current_user.id)
        else
          flash[:notice] = "Non puoi eliminare le prenotazioni degli altri!"
          redirect_to root_path
        end
      end
    end
  end

  def destroy
    if (current_user.has_role? :player)
        flash[:notice] = "Non puoi eliminare le prenotazioni dei campi sportivi."
        redirect_to root_path
      else
        id = params[:id]
        @book = Book.find(id)
        if (current_user.has_role? :owner, @book) || (current_user.has_role? :admin) #Se l'utente è l'effettivo possessore della prenotazione allora può eliminarla
          Timetable.all.where(:id => @book.timetable_id).destroy_all
          @book.destroy
          redirect_to ground_path(params[:ground_id])
        else
          flash[:notice] = "Non puoi eliminare le prenotazioni degli altri!"
          redirect_to root_path
        end
      end
  end
  
end
