class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates_presence_of :title,
                        :rating,
                        :text

  def self.top_reviews
    select('reviews.*').order(rating: :desc).limit(3)
  end

  def self.bottom_reviews
    select('reviews.*').order(:rating).limit(3)
  end
end
