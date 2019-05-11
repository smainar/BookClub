require 'rails_helper'

RSpec.describe "new book form", type: :feature do
  it "displays a form to add a new book - includes title, publication year, pages, cover image (optional), and authors" do

    visit new_book_path

    fill_in "book[title]", with: "the talisman"
    fill_in "book[publication_year]", with: 1984
    fill_in "book[pages]", with: 921
    fill_in "book[cover_image]", with: "https://images-na.ssl-images-amazon.com/images/I/411-vun7rML._SX320_BO1,204,203,200_.jpg"
    fill_in "book[authors]", with: "stephen king, peter straub"

    click_on "Create Book"

    new_book = Book.last

    expect(current_path).to eq(book_path(new_book))

    expect(page).to have_content(new_book.title)
    expect(page).to have_content(new_book.publication_year)
    expect(page).to have_content(new_book.pages)
    expect(page).to have_css("img[src='#{new_book.cover_image}']")
    expect(page).to have_content(new_book.authors.first.name)
  end

  it "displays flash notice when there is an invalid page entry" do
    visit new_book_path

    fill_in "book[title]", with: "the talisman"
    fill_in "book[publication_year]", with: 1984
    fill_in "book[pages]", with: -921
    fill_in "book[cover_image]", with: "https://images-na.ssl-images-amazon.com/images/I/411-vun7rML._SX320_BO1,204,203,200_.jpg"
    fill_in "book[authors]", with: "stephen king, peter straub"

    click_on "Create Book"

    expect(page).to have_content("Invalid entry. Please try again.")
  end

  it "displays flash notice when there is a duplicate title entry" do
    b1 = Book.create!(title: "The Talisman", publication_year: 1984, pages: 200)

    visit new_book_path

    fill_in "book[title]", with: "the talisman"
    fill_in "book[publication_year]", with: 1984
    fill_in "book[pages]", with: 200
    fill_in "book[cover_image]", with: "https://images-na.ssl-images-amazon.com/images/I/411-vun7rML._SX320_BO1,204,203,200_.jpg"
    fill_in "book[authors]", with: "stephen king, peter straub"

    click_on "Create Book"

    expect(page).to have_content("Invalid entry. Please try again.")
    expect(current_path).to eq(new_book_path)
  end
end
