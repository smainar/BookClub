class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    user = User.find_or_create_by(username: params[:review][:name].titleize)
    review = user.reviews.new(review_params)
    if user.reviews.pluck(:book_id).include?(book) || review_params == nil
      flash.notice = "You have already left a review for this book."
      redirect_to book_path(book)
    else
      review.save
      book.reviews << review
      redirect_to book_path(book)
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :text)
  end
end
