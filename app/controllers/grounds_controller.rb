class GroundsController < ApplicationController

  def index
    grounds = Ground.all
    if "#{params[:search]}" != ""
      grounds = grounds.where(["title LIKE ?","%#{params[:search]}%"])
    end
    if "#{params[:priceFrom]}" != ""
      grounds = grounds.where(["price >= ?", "#{params[:priceFrom]}".to_i])
    end
    if "#{params[:priceTo]}" != ""
      grounds = grounds.where(["price <= ?", "#{params[:priceTo]}".to_i])
    end
    @grounds = grounds
  end

  def show
    id = params[:id]
    @ground = Ground.find(id)

    @books = Book.all

    reviews = Review.all
    reviews = reviews.where(["ground_id LIKE ?", "#{params[:id]}"])
    @reviews = reviews
  end

end
