require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :publication_year }
    it { should validate_presence_of :pages }
  end

  describe "relationships" do
    it { should have_many :book_authors }
    it { should have_many(:authors).through(:book_authors) }
    it { should have_many :reviews }
  end

  describe "instance methods" do
    before(:each) do
      @author_1 = Author.create!(name: "Author 1")
      @author_2 = Author.create!(name: "Author 2")
      @author = Author.all

      @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
      @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
      @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png", authors:[@author_1, @author_2])
      @books = Book.all

      @user_1 = User.create!(username: "User 1")
      @user_2 = User.create!(username: "User 2")
      @user_3 = User.create!(username: "User 3")
      @user_4 = User.create!(username: "User 4")

      @review_1 = @book_1.reviews.create!(user: @user_1, title: "Review Book 1.1", rating: 1, text: "Cool")
      @review_2 = @book_1.reviews.create!(user: @user_2, title: "Review Book 1.2", rating: 2, text: "Cooler")
      @review_3 = @book_2.reviews.create!(user: @user_3, title: "Review Book 2", rating: 3, text: "Coolest")
      @review_4 = @book_3.reviews.create!(user: @user_4, title: "Review Book 3", rating: 1, text: "Worst")
      @reviews = Review.all
    end

    it ".average_rating" do
      expect(@book_1.average_rating).to eq(1.5)
      expect(@book_2.average_rating).to eq(3)
    end

    it ".review_count" do
      expect(@book_1.review_count).to eq(2)
      expect(@book_2.review_count).to eq(1)
    end

    it ".co_authors" do
      expect(@book_3.co_authors(@author_1.id)).to eq([@author_2])
    end

    it ".repeat_user" do
      expect(@book_1.repeat_user(@user_1.id)).to eq(true)
      expect(@book_3.repeat_user(@user_3.id)).to eq(false)
    end
  end

  describe "class methods" do
    before(:each) do
      @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
      @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
      @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

      @books = Book.all

      @user_1 = User.create!(username: "User 1")
      @user_2 = User.create!(username: "User 2")
      @user_3 = User.create!(username: "User 3")
      @user_4 = User.create!(username: "User 4")

      @review_1 = @book_1.reviews.create!(user: @user_1, title: "Review Book 1.1", rating: 1, text: "Cool")
      @review_2 = @book_1.reviews.create!(user: @user_2, title: "Review Book 1.2", rating: 2, text: "Cooler")
      @review_3 = @book_2.reviews.create!(user: @user_3, title: "Review Book 2", rating: 3, text: "Coolest")
      @review_4 = @book_3.reviews.create!(user: @user_4, title: "Review Book 3", rating: 1, text: "Worst")
    end

    it ".order_average_rating" do
      expect(@books.order_average_rating("asc")).to eq([@book_3, @book_1, @book_2])
      expect(@books.order_average_rating("desc")).to eq([@book_2, @book_1, @book_3])
    end

    it ".order_review_count" do

      user_5 = User.create!(username: "User 5")
      user_6 = User.create!(username: "User 6")

      review_5 = @book_3.reviews.create!(user: user_5, title: "Review Book 3.2", rating: 1, text: "Worst")
      review_6 = @book_3.reviews.create!(user: user_6, title: "Review Book 3.3", rating: 1, text: "Worst")

      expect(@books.order_review_count("asc")).to eq([@book_2, @book_1, @book_3])
      expect(@books.order_review_count("desc")).to eq([@book_3, @book_1, @book_2])
    end

    it ".order_page_count" do
      expect(@books.order_page_count("asc")).to eq([@book_1, @book_2, @book_3])
      expect(@books.order_page_count("desc")).to eq([@book_3, @book_2, @book_1])
    end

    it ".highest_rated_books" do

      user_5 = User.create!(username: "User 5")
      user_6 = User.create!(username: "User 6")

      book_4 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

      review_5 = book_4.reviews.create!(user: user_5, title: "Review Book 4.1", rating: 4, text: "Best")
      review_6 = book_4.reviews.create!(user: user_6, title: "Review Book 4.2", rating: 5, text: "Bestest")

      expect(Book.highest_rated_books).to eq([book_4, @book_2, @book_1])
    end

    it ".worst_rated_books" do

      book_4 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

      user_5 = User.create!(username: "User 5")
      user_6 = User.create!(username: "User 6")

      review_5 = book_4.reviews.create!(user: user_5, title: "Review Book 4.1", rating: 4, text: "Best")
      review_6 = book_4.reviews.create!(user: user_6, title: "Review Book 4.2", rating: 5, text: "Bestest")

      expect(Book.worst_rated_books).to eq([@book_3, @book_1, @book_2])
    end

    it ".titles" do
      expect(Book.titles).to eq([@book_1.title, @book_2.title, @book_3.title])
    end
  end

  describe "deleting the book" do
    before(:each) do
      @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
      @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
      @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

      @books = Book.all

      @user_1 = User.create!(username: "User 1")
      @user_2 = User.create!(username: "User 2")
      @user_3 = User.create!(username: "User 3")
      @user_4 = User.create!(username: "User 4")

      @review_1 = @book_1.reviews.create!(user: @user_1, title: "Review Book 1.1", rating: 1, text: "Cool")
      @review_2 = @book_1.reviews.create!(user: @user_2, title: "Review Book 1.2", rating: 2, text: "Cooler")
      @review_3 = @book_2.reviews.create!(user: @user_3, title: "Review Book 2", rating: 3, text: "Coolest")
      @review_4 = @book_3.reviews.create!(user: @user_4, title: "Review Book 3", rating: 1, text: "Worst")

      @reviews = Review.all
    end

    it "deletes the book from the book show page" do
      Book.destroy(@book_1.id)

      expect(@books).to_not include(@book_1)
      expect(@books).to include(@book_2)
    end

    it "destroys the book's reviews" do
      Book.destroy(@book_1.id)

      expect(@reviews).to_not include(@review_1)
      expect(@reviews).to_not include(@review_2)
      expect(@reviews).to include(@review_3)
    end
  end
end
