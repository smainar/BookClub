class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors, dependent: :destroy
  has_many :book_authors, dependent: :destroy

  validates_presence_of :name
end
