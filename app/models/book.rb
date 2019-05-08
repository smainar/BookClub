class Book < ApplicationRecord
  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates_presence_of :title,
                        :publication_year,
                        :pages,
                        :cover_image

  def average_rating
    reviews.average(:rating)
  end

  def review_count
    reviews.count
  end
end
