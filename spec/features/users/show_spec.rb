require 'rails_helper'

RSpec.describe "user show page", type: :feature do
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
    @user_3 = User.create!(username: "User 3")
    @user_4 = User.create!(username: "User 4")

    @users = User.all

    @review_1 = @book_1.reviews.create!(user: @user_1, title: "Review Book 1.1", rating: 1, text: "Cool")
    @review_2 = @book_1.reviews.create!(user: @user_2, title: "Review Book 1.2", rating: 2, text: "Cooler")
    @review_3 = @book_2.reviews.create!(user: @user_3, title: "Review Book 3", rating: 3, text: "Coolest")
    @review_4 = @book_2.reviews.create!(user: @user_1, title: "Review Book 1.3", rating: 5, text: "Best book ever")
    @review_5 = @book_3.reviews.create!(user: @user_2, title: "Review Book 1.4", rating: 2, text: "Pretty bad")
    @review_6 = @book_3.reviews.create!(user: @user_4, title: "Review Book 1.5", rating: 4, text: "Fun book")

    @reviews = Review.all
  end

  describe "it displays all the reviews the user has written" do
    it "includes the review title, description/text, book title, rating, book thumbnail image, and date written" do
      visit user_path(@user_1)

      expect(page).to have_content(@user_1.username)

      within "#review-#{@review_1.id}" do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.text)
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_css("img[src='#{@book_1.cover_image}']")
        expect(page).to have_content(@review_1.created_at.to_formatted_s(:long).slice(0...-6))

        expect(page).to_not have_content(@review_2.title)
        expect(page).to_not have_content(@review_2.text)
        expect(page).to_not have_content(@book_2.title)
      end

      within "#review-#{@review_4.id}" do
        expect(page).to have_content(@review_4.title)
        expect(page).to have_content(@review_4.text)
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@review_4.rating)
        expect(page).to have_css("img[src='#{@book_2.cover_image}']")
        expect(page).to have_content(@review_4.created_at.to_formatted_s(:long).slice(0...-6))

        expect(page).to_not have_content(@review_5.title)
        expect(page).to_not have_content(@review_5.text)
        expect(page).to_not have_content(@book_3.title)
      end
    end

    it "deletes a single review the user has written" do
      visit user_path(@user_1)

      within "#review-#{@review_4.id}" do
        expect(page).to have_content(@review_4.title)
        click_on "Delete this Review"
      end
      expect(page).to_not have_content(@review_4.title)
    end
  end
end
