class Review < ApplicationRecord
  attr_accessor :name

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

  def self.top_rated_review
    select('reviews.*').order(rating: :desc).first
  end
end
