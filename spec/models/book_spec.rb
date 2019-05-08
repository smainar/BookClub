require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :publication_year }
    it { should validate_presence_of :pages }
    it { should validate_presence_of :cover_image }
  end

  describe "relationships" do
    it { should have_many :book_authors }
    it { should have_many(:authors).through(:book_authors) }
    it { should have_many :reviews }
  end

  describe "class methods" do
    before(:each) do
      @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
      @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
      @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

      @books = Book.all

      @review_1 = @book_1.reviews.create!(username: "User 1", title: "Review Book 1.1", rating: 1, text: "Cool")
      @review_2 = @book_1.reviews.create!(username: "User 2", title: "Review Book 1.2", rating: 2, text: "Cooler")
      @review_3 = @book_2.reviews.create!(username: "User 3", title: "Review Book 3", rating: 3, text: "Coolest")
    end

    it ".average_rating" do
      avg_rating = 1.5

      expect(@book_1.average_rating.to_f).to eq(avg_rating)

      avg_rating_2 = 3

      expect(@book_2.average_rating.to_f).to eq(avg_rating_2)
    end

    it ".review_count" do
      review_count = 2

      expect(@book_1.review_count).to eq(review_count)

      review_count_2 = 1

      expect(@book_2.review_count).to eq(review_count_2)
    end
  end
end
