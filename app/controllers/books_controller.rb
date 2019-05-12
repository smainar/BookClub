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
    @book = Book.new
  end

  def create
    book_title = book_params[:title].strip.downcase.titleize
    books = Book.all
    if books.titles.include?(book_title) || book_params[:pages].to_i <= 0 || book_params == nil
      flash.notice = "Invalid entry. Please try again."
      redirect_to new_book_path
    else
      book = Book.new(book_params)
      book.update(title: book_title)
      authors = author_params[:authors].titleize.split(", ")
      authors.each do |author|
        book.authors << Author.find_or_create_by(name: author)
      end
      book.save
      redirect_to book_path(book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :publication_year, :pages, :cover_image)
  end

  def author_params
    params.require(:book).permit(:authors)
  end
end
