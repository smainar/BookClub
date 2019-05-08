require 'rails_helper'

RSpec.describe "books index page", type: :feature do
  before(:each) do
    @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
    @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
    @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

    @review_1 = @book_1.reviews.create!(username: "User 1", title: "Review Book 1.1", rating: 1, text: "Cool")
    @review_2 = @book_1.reviews.create!(username: "User 2", title: "Review Book 1.2", rating: 2, text: "Cooler")
    @review_3 = @book_2.reviews.create!(username: "User 3", title: "Review Book 3", rating: 3, text: "Coolest")
  end

  it "visitor sees all book titles, author, pages, and year in database" do

    visit books_path

    expect(page).to have_content(@book_1.title)
    expect(page).to have_content(@book_1.publication_year)
    expect(page).to have_content(@book_1.pages)
    expect(page).to have_css("img[src='#{@book_1.cover_image}']")

    expect(page).to have_content(@book_2.title)
    expect(page).to have_content(@book_2.publication_year)
    expect(page).to have_content(@book_2.pages)
    expect(page).to have_css("img[src='#{@book_2.cover_image}']")
  end

# First test for User Story 7
  it "visitor sees average book rating and total number of reviews for each book" do

    visit books_path

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(@book_1.average_rating.to_f)
      expect(page).to have_content(@book_1.review_count)
    end

    within "#book-#{@book_2.id}" do
      expect(page).to have_content(@book_2.average_rating.to_f)
      expect(page).to have_content(@book_2.review_count)
    end
  end
end
