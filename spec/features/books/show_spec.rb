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
    @review_4 = @book_1.reviews.create!(username: "User 1", title: "Review Book 1.3", rating: 5, text: "Best book ever")
    @review_5 = @book_1.reviews.create!(username: "User 2", title: "Review Book 1.4", rating: 2, text: "Pretty bad")
    @review_6 = @book_1.reviews.create!(username: "User 4", title: "Review Book 1.5", rating: 4, text: "Fun book")
    @review_7 = @book_1.reviews.create!(username: "User 5", title: "Review Book 1.6", rating: 5, text: "Favorite book")
  end

  it "displays the title, author, and page count for a specific book" do

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

  it "displays a list of reviews - with title, user, rating, and text - for a specific book" do

   visit book_path(@book_1)

   expect(page).to have_content(@review_1.username)
   expect(page).to have_content(@review_1.title)
   expect(page).to have_content(@review_1.rating)
   expect(page).to have_content(@review_1.text)

   expect(page).to have_content(@review_2.username)
   expect(page).to have_content(@review_2.title)
   expect(page).to have_content(@review_2.rating)
   expect(page).to have_content(@review_2.text)

   expect(page).to_not have_content(@review_3.username)
 end

 it "displays statistics for top 3 and bottom 3 reviews (title, rating, user) and the overall rating for a specific book" do

   visit book_path(@book_1)

   expect(page).to have_content(@book_1.average_rating.to_f.round(1))
   expect(current_path).to eq(book_path(@book_1))

   within "#top-reviews" do
     expect(page).to have_content(@review_4.title)
     expect(page).to have_content(@review_4.rating)
     expect(page).to have_content(@review_4.username)
     expect(page).to have_content(@review_7.title)
     expect(page).to have_content(@review_7.rating)
     expect(page).to have_content(@review_7.username)
     expect(page).to have_content(@review_6.title)
     expect(page).to have_content(@review_6.rating)
     expect(page).to have_content(@review_6.username)
   end

   within "#bottom-reviews" do
     expect(page).to have_content(@review_1.title)
     expect(page).to have_content(@review_1.rating)
     expect(page).to have_content(@review_1.username)
     expect(page).to have_content(@review_5.title)
     expect(page).to have_content(@review_5.rating)
     expect(page).to have_content(@review_5.username)
     expect(page).to have_content(@review_2.title)
     expect(page).to have_content(@review_2.rating)
     expect(page).to have_content(@review_2.username)
   end
 end
end
