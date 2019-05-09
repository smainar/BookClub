require 'rails_helper'

RSpec.describe "book show page", type: :feature do
  before(:each) do
    @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
    @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
    @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

    @author_1 = @book_1.authors.create!(name: "Author 1")
    @author_2 = @book_1.authors.create!(name: "Author 2")
    @author_3 = @book_2.authors.create!(name: "Author 3")
    @author_4 = @book_3.authors.create!(name: "Author 4")

    @review_1 = @book_1.reviews.create!(username: "User 1", title: "Review Book 1.1", rating: 1, text: "Cool")
    @review_2 = @book_1.reviews.create!(username: "User 2", title: "Review Book 1.2", rating: 2, text: "Cooler")
    @review_3 = @book_2.reviews.create!(username: "User 3", title: "Review Book 3", rating: 3, text: "Coolest")
  end

  it "displays the title, author, and pages for a specific book" do

    visit book_path(@book_1)

    expect(page).to have_content(@book_1.title)
    expect(page).to have_content(@book_1.publication_year)
    expect(page).to have_content(@book_1.pages)
    expect(page).to have_content(@author_1.name)
    expect(page).to have_content(@author_2.name)
    expect(page).to have_css("img[src='#{@book_1.cover_image}']")
    expect(current_path).to eq(book_path(@book_1))

    expect(page).to_not have_content(@book_2.title)
  end
end
