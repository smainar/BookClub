class BooksController < ApplicationController
  def index
    @highest_rated_books = Book.highest_rated_books
    @worst_rated_books = Book.worst_rated_books
    if params[:order_by_rating]
      @books = Book.order_average_rating(params[:order_by_rating])
    elsif params[:order_by_reviews]
      @books = Book.order_review_count(params[:order_by_reviews])
    elsif params[:order_by_pages]
      @books = Book.order_page_count(params[:order_by_pages])
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    
  end
end
