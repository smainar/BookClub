require 'rails_helper'

RSpec.describe "books index page", type: :feature do
  before(:each) do
    @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
    @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
    @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png")

    @books = Book.all

    @author_1 = @book_1.authors.create!(name: "Author 1")
    @author_2 = @book_1.authors.create!(name: "Author 2")
    @author_3 = @book_2.authors.create!(name: "Author 3")
    @author_4 = @book_3.authors.create!(name: "Author 4")

    @user_1 = User.create!(username: "User 1")
    @user_2 = User.create!(username: "User 2")
    @user_3 = User.create!(username: "User 3")
    @user_4 = User.create!(username: "User 4")

    @review_1 = @book_1.reviews.create!(user: @user_1, title: "Review Book 1.1", rating: 1, text: "Cool")
    @review_2 = @book_1.reviews.create!(user: @user_2, title: "Review Book 1.2", rating: 2, text: "Cooler")
    @review_3 = @book_2.reviews.create!(user: @user_3, title: "Review Book 2", rating: 3, text: "Coolest")
    @review_4 = @book_3.reviews.create!(user: @user_4, title: "Review Book 3.1", rating: 1, text: "Worst")
  end

  it "displays all book titles, authors, pages, and year in database" do
    visit books_path

    expect(page).to have_content(@book_1.title)
    expect(page).to have_content(@author_1.name)
    expect(page).to have_content(@author_2.name)
    expect(page).to have_content(@book_1.publication_year)
    expect(page).to have_content(@book_1.pages)
    expect(page).to have_css("img[src='#{@book_1.cover_image}']")

    expect(page).to have_content(@book_2.title)
    expect(page).to have_content(@author_3.name)
    expect(page).to have_content(@book_2.publication_year)
    expect(page).to have_content(@book_2.pages)
    expect(page).to have_css("img[src='#{@book_2.cover_image}']")
  end

  it "displays average book rating and total number of reviews for each book" do
    visit books_path

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(@book_1.average_rating.to_f.round(2))
      expect(page).to have_content(@book_1.review_count)
    end

    within "#book-#{@book_2.id}" do
      expect(page).to have_content(@book_2.average_rating.to_f.round(2))
      expect(page).to have_content(@book_2.review_count)
    end
  end

  it "displays all books sorted by average rating" do
    visit books_path

    click_on "Average Rating ascending"
    expect(current_path).to eq(books_path)
    expect(page.all('li')[0]).to have_content(@book_3.title)
    expect(page.all('li')[1]).to have_content(@book_1.title)
    expect(page.all('li')[2]).to have_content(@book_2.title)

    visit books_path

    click_on "Average Rating descending"
    expect(current_path).to eq(books_path)
    expect(page.all('li')[0]).to have_content(@book_2.title)
    expect(page.all('li')[1]).to have_content(@book_1.title)
    expect(page.all('li')[2]).to have_content(@book_3.title)
  end

  it "displays all books sorted by number of reviews" do
    visit books_path

    user_5 = User.create!(username: "User 5")
    user_6 = User.create!(username: "User 6")

    review_5 = @book_3.reviews.create!(user: user_5, title: "Review Book 3.2", rating: 1, text: "Worst")
    review_6 = @book_3.reviews.create!(user: user_6, title: "Review Book 3.3", rating: 1, text: "Worst")

    click_on "Number of Reviews ascending"
    expect(current_path).to eq(books_path)
    expect(page.all('li')[0]).to have_content(@book_2.title)
    expect(page.all('li')[1]).to have_content(@book_1.title)
    expect(page.all('li')[2]).to have_content(@book_3.title)

    visit books_path

    click_on "Number of Reviews descending"
    expect(current_path).to eq(books_path)
    expect(page.all('li')[0]).to have_content(@book_3.title)
    expect(page.all('li')[1]).to have_content(@book_1.title)
    expect(page.all('li')[2]).to have_content(@book_2.title)
  end

  it "displays all books sorted by page count" do
    visit books_path

    click_on "Page Number ascending"
    expect(current_path).to eq(books_path)
    expect(page.all('li')[0]).to have_content(@book_1.title)
    expect(page.all('li')[1]).to have_content(@book_2.title)
    expect(page.all('li')[2]).to have_content(@book_3.title)

    visit books_path

    click_on "Page Number descending"
    expect(current_path).to eq(books_path)
    expect(page.all('li')[0]).to have_content(@book_3.title)
    expect(page.all('li')[1]).to have_content(@book_2.title)
    expect(page.all('li')[2]).to have_content(@book_1.title)
  end

  it "displays a statistics area with the three highest-rated and worst-rated books - with book title and average rating" do

    book_4 = Book.create!(title: "Book 4", publication_year: 2002, pages: 115, cover_image: "book4.png")

    user_5 = User.create!(username: "User 5")
    user_6 = User.create!(username: "User 6")

    review_5 = book_4.reviews.create!(user: user_5, title: "Review Book 4.1", rating: 4, text: "Best")
    review_6 = book_4.reviews.create!(user: user_6, title: "Review Book 4.2", rating: 5, text: "Bestest")

    visit books_path

    within ".statistics-highest-rated-book-" do
      expect(current_path).to eq(books_path)
      expect(page).to have_content(book_4.title)
      expect(page).to have_content(book_4.average_rating.to_f.round(1))
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@book_2.average_rating.to_f.round(1))
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_1.average_rating.to_f.round(1))
    end

    within ".statistics-worst-rated-book-" do
      expect(current_path).to eq(books_path)
      expect(page).to have_content(@book_3.title)
      expect(page).to have_content(@book_3.average_rating.to_f.round(2))
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_1.average_rating.to_f.round(2))
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@book_2.average_rating.to_f.round(2))
    end
  end

  it "displays a link to add a new book, which takes visitor to a new book path when clicked on" do
    visit books_path

    click_link "Add New Book"

    expect(current_path).to eq(new_book_path)
  end
end
