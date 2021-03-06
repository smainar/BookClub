class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    user = User.find_or_create_by(username: params[:review][:user].strip.downcase.titleize)
    review = user.reviews.new(review_params)
    if book.repeat_user(user.id) || review_params.values.include?("") || user.username == ""
      flash.notice = "Error."
      redirect_to book_path(book)
    else
      review.save
      book.reviews << review
      redirect_to book_path(book)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    user = @review.user
    @review.destroy
    redirect_to user_path(user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :text)
  end
end
