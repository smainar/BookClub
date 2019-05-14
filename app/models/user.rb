class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :username

  def order_reviews(order_by_date)
    if order_by_date == "oldest"
      reviews.order(created_at: :asc)
    elsif order_by_date == "recent"
      reviews.order(created_at: :desc)
    end
  end
end
