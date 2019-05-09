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

  def self.order_average_rating(order_by_rating)
    if order_by_rating == "asc"
      select('books.*, avg(reviews.rating)').joins(:reviews).group('id').order('avg(reviews.rating)')
    elsif order_by_rating == "desc"
      select('books.*, avg(reviews.rating)').joins(:reviews).group('id').order('avg(reviews.rating) DESC')
    end
  end

  def self.order_review_count(order_by_reviews)
    if order_by_reviews == "asc"
      select('books.*, count(reviews.id)').joins(:reviews).group('id').order('count(reviews.id)')
    elsif order_by_reviews == "desc"
      select('books.*, count(reviews.id)').joins(:reviews).group('id').order('count(reviews.id) DESC')
    end
  end

  def self.order_page_count(order_by_pages)
    if order_by_pages == "asc"
      select('books.*').order(:pages)
    elsif order_by_pages == "desc"
      select('books.*').order(pages: :desc)
    end
  end

  def self.highest_rated_books
    select('books.*, avg(reviews.rating)').joins(:reviews).group('id').order('avg(reviews.rating) DESC').limit(3)
  end
end
