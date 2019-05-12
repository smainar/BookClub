require 'rails_helper'

RSpec.describe "new review form", type: :feature do
  before(:each) do
    @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")

    @author_1 = @book_1.authors.create!(name: "Author 1")

    @user_1 = User.create!(username: "User 1")

    @review_1 = @book_1.reviews.create!(user: @user_1, title: "Review Book 1.1", rating: 1, text: "Cool")
  end

  describe "visitor sees a form to add a new review - with a field for title, user, rating, and text" do
    it "returns to that book's show page, after the form is submitted, and displays the review" do
      visit new_book_review_path(@book_1)

      fill_in "review[title]", with: "Hello"
      fill_in "review[name]", with: "User 42"
      select("5", from: "review[rating]")
      fill_in "review[text]", with: "Hello World"
      click_on "Submit Review"

      new_review = Review.last

      expect(current_path).to eq(book_path(@book_1))

      expect(page).to have_content(new_review.title)
      expect(page).to have_content(new_review.user.username)
      expect(page).to have_content(new_review.rating)
      expect(page).to have_content(new_review.text)
    end

    it "returns to that book's show page, after the form is submitted with untitleized username, and displays the username titleized" do
      visit new_book_review_path(@book_1)

      fill_in "review[title]", with: "Hello"
      fill_in "review[name]", with: "UsER 42"
      select("5", from: "review[rating]")
      fill_in "review[text]", with: "Hello World"
      click_on "Submit Review"

      new_review = Review.last

      expect(current_path).to eq(book_path(@book_1))
      expect(page).to have_content(new_review.user.username)
    end

    it "returns to that book's show page, after the form is submitted with existing user, and displays error" do
      visit new_book_review_path(@book_1)

      fill_in "review[title]", with: "Hello"
      fill_in "review[name]", with: @review_1.user.username
      select("5", from: "review[rating]")
      fill_in "review[text]", with: "Hello World"
      click_on "Submit Review"

      expect(current_path).to eq(book_path(@book_1))
      expect(page).to have_content("Error.")
      expect(page).to_not have_content("Hello World")
    end

    it "returns to that book's show page, after the form is submitted with empty param, and displays error" do
      visit new_book_review_path(@book_1)

      fill_in "review[title]", with: ""
      fill_in "review[name]", with: "User 42"
      select("5", from: "review[rating]")
      fill_in "review[text]", with: "Hello World"
      click_on "Submit Review"

      expect(current_path).to eq(book_path(@book_1))
      expect(page).to have_content("Error.")
      expect(page).to_not have_content("Hello World")
    end
  end
end
