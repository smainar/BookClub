require 'rails_helper'

RSpec.describe "author show page", type: :feature do
  before(:each) do
    @author_1 = Author.create!(name: "Author 1")
    @author_2 = Author.create!(name: "Author 2")
    @author_3 = Author.create!(name: "Author 3")

    @book_1 = @author_1.books.create!(title: "Book 1", publication_year: 1999, pages: 100, cover_image: "book1.png")
    @book_2 = @author_1.books.create!(title: "Book 2", publication_year: 2000, pages: 105, cover_image: "book2.png")
    @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 110, cover_image: "book3.png", authors:[@author_1, @author_2])
    @book_4 = @author_3.books.create!(title: "Book 4", publication_year: 2002, pages: 120, cover_image: "book4.png")
    @book_5 = @author_2.books.create!(title: "Book 5", publication_year: 2003, pages: 125, cover_image: "book5.png")

    @user_1 = User.create!(username: "User 1")
    @user_2 = User.create!(username: "User 2")
    @user_3 = User.create!(username: "User 3")

    @review_1 = @user_1.reviews.create!(title: "Review Book 1.1", rating: 1, text: "Worst", book: @book_1)
    @review_2 = @user_2.reviews.create!(title: "Review Book 1.2", rating: 4, text: "Best", book: @book_1)
    @review_3 = @user_3.reviews.create!(title: "Review Book 2", rating: 5, text: "Best", book: @book_2)
  end

  it 'displays all books by that author with title, pages, publication year, cover image, and co-authors' do

    visit author_path(@author_1)

    expect(current_path).to eq(author_path(@author_1))
    expect(page).to have_content(@author_1.name)
    expect(page).to_not have_content(@book_4.title)

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_1.pages)
      expect(page).to have_content(@book_1.publication_year)
      expect(page).to have_css("img[src='#{@book_1.cover_image}']")
      expect(page).to_not have_content(@author_2.name)
      expect(page).to_not have_content(@author_3.name)
    end

    within "#book-#{@book_2.id}" do
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@book_2.pages)
      expect(page).to have_content(@book_2.publication_year)
      expect(page).to have_css("img[src='#{@book_2.cover_image}']")
      expect(page).to_not have_content(@author_2.name)
      expect(page).to_not have_content(@author_3.name)
    end

    within "#book-#{@book_3.id}" do
      expect(page).to have_content(@book_3.title)
      expect(page).to have_content(@book_3.pages)
      expect(page).to have_content(@book_3.publication_year)
      expect(page).to have_css("img[src='#{@book_3.cover_image}']")
      expect(page).to have_content(@author_2.name)
      expect(page).to_not have_content(@author_3.name)
      expect(page).to_not have_content(@author_3.name)
    end
  end

  it "displays each book's highest rated review with title, rating, and username" do
    visit author_path(@author_1)

    expect(current_path).to eq(author_path(@author_1))

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.rating)
      expect(page).to have_content(@review_2.user.username)
      expect(page).to_not have_content(@review_1.title)
      expect(page).to_not have_content(@review_3.title)
    end

    within "#book-#{@book_2.id}" do
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@review_3.title)
      expect(page).to have_content(@review_3.rating)
      expect(page).to have_content(@review_3.user.username)
      expect(page).to_not have_content(@review_1.title)
      expect(page).to_not have_content(@review_2.title)
    end
  end

  it "displays the user names(s) as a link, which takes the visitor to that user's show page" do
    visit author_path(@author_1)

    within "#top-rated-review-#{@book_1.id}" do
      click_link @user_2.username

      expect(current_path).to eq(user_path(@user_2))
    end

    visit author_path(@author_1)

    within "#top-rated-review-#{@book_2.id}" do
      click_link @user_3.username

      expect(current_path).to eq(user_path(@user_3))
    end
  end

  it "visits author page and deletes a single author and returns user to book index page" do
    visit author_path(@author_1)

    expect(page).to have_content(@author_1.name)
    expect(page).to have_content(@book_1.title)
    expect(page).to have_content(@book_2.title)
    expect(page).to have_content(@book_3.title)
    expect(page).to have_content(@author_2.name)

    click_on "Delete this Author"
    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(@book_1.title)
    expect(page).to_not have_content(@book_2.title)
    expect(page).to_not have_content(@book_3.title)
    expect(page).to_not have_content(@author_1.name)
    expect(page).to have_content(@author_2.name)
  end
end
