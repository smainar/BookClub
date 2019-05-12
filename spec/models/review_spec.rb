require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :text }
  end

  describe "relationships" do
    it { should belong_to :book }
    it { should belong_to :user }
  end

  describe "class methods" do
    before(:each) do
      @book_1 = Book.create(title: "Harry Potter & the Sorcerer's Stone", publication_year: 1997, pages: 293, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51HSkTKlauL._SX346_BO1,204,203,200_.jpg")

      @user_1 = User.create!(username: "User 1")
      @user_2 = User.create!(username: "User 2")
      @user_3 = User.create!(username: "User 3")
      @user_4 = User.create!(username: "User 4")

      @review_1 = @user_1.reviews.create!(title: "Review Book 3.1", rating: 1, text: "Worst", book: @book_1)
      @review_2 = @user_2.reviews.create!(title: "Review Book 3.2", rating: 5, text: "Best", book: @book_1)
      @review_3 = @user_3.reviews.create!(title: "Review Book 3.3", rating: 3, text: "Okay", book: @book_1)
      @review_4 = @user_4.reviews.create!(title: "Review Book 3.4", rating: 4, text: "Good", book: @book_1)

      @reviews = Review.all
    end

    it '.top_reviews' do
      expect(@reviews.top_reviews).to eq([@review_2, @review_4, @review_3])
    end

    it '.bottom_reviews' do
      expect(@reviews.bottom_reviews).to eq([@review_1, @review_3, @review_4])
    end

    it '.top_rated_review' do
      expect(@reviews.top_rated_review).to eq(@review_2)
    end
  end
end
