class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:order_by_date]
      @reviews = @user.order_reviews(params[:order_by_date])
    else
      @reviews = @user.reviews
    end
  end
end
