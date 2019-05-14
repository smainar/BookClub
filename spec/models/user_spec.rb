require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :username}
  end

  describe "relationships" do
    it { should have_many :reviews }
  end

  describe "instance methods" do
    before(:each) do
      @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
      @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
      @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

      @author_1 = @book_1.authors.create!(name: "Author 1")
      @author_2 = @book_1.authors.create!(name: "Author 2")
      @author_3 = @book_2.authors.create!(name: "Author 3")
      @author_4 = @book_3.authors.create!(name: "Author 4")

      @user_1 = User.create!(username: "User 1")
      @user_2 = User.create!(username: "User 2")

      @users = User.all

      travel_to Time.new(2019, 05, 12, 03, 00, 00)
      @review_1 = @book_1.reviews.create!(user: @user_1, title: "Review Book 1.1", rating: 1, text: "Cool")

      travel_to Time.new(2019, 05, 12, 02, 00, 00)
      @review_2 = @book_1.reviews.create!(user: @user_2, title: "Review Book 1.2", rating: 2, text: "Cooler")

      travel_to Time.new(2019, 05, 12, 01, 00, 00)
      @review_3 = @book_2.reviews.create!(user: @user_1, title: "Review Book 3", rating: 3, text: "Coolest")

      travel_to Time.new(2019, 05, 12, 04, 00, 00)
      @review_4 = @book_2.reviews.create!(user: @user_2, title: "Review Book 1.3", rating: 5, text: "Best book ever")

      travel_to Time.new(2019, 05, 12, 05, 00, 00)
      @review_5 = @book_3.reviews.create!(user: @user_1, title: "Review Book 1.4", rating: 2, text: "Pretty bad")

      @reviews = Review.all
    end

    it "order_reviews" do
      expect(@user_1.order_reviews("recent")).to eq([@review_5, @review_1, @review_3])
      expect(@user_2.order_reviews("oldest")).to eq([@review_2, @review_4])
    end
  end
end
