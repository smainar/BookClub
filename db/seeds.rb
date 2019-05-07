# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require './app/models/book.rb'
require './app/models/author.rb'
require './app/models/review.rb'
require './app/models/book_author.rb'

Review.destroy_all
BookAuthor.destroy_all
Author.destroy_all
Book.destroy_all

a1 = Author.create(name: "RL Stein")
a2 = Author.create(name: "John Foreman")
a3 = Author.create(name: "Stephen Hawking")
a4 = Author.create(name: "Paulo Coehlo")
a5 = Author.create(name: "JK Rowling")
a6 = Author.create(name: "Orson Scott Card")
a7 = Author.create(name: "HG Wells")
a8 = Author.create(name: "Nate Silver")
a9 = Author.create(name: "Wes McKinney")
a10 = Author.create(name: "John Smith")

b1 = Book.create(title: "The New Machiavelli", publication_year: 1911, pages:180, cover_image: "https://pictures.abebooks.com/isbn/9780140005752-uk.jpg", authors: [a7])
b2 = Book.create(title: "Data Smart", publication_year: 2013, pages: 235, cover_image: "https://images-na.ssl-images-amazon.com/images/I/41ex8HFBWnL._SX397_BO1,204,203,200_.jpg", authors: [a2,a10])
b3 = Book.create(title: "God Created the Integers", publication_year: 2007, pages:197, cover_image: "https://images-na.ssl-images-amazon.com/images/I/71X9nwKsXIL.jpg", authors: [a3])
b4 = Book.create(title: "Night of the Living Dummy", publication_year: 1993, pages: 134, cover_image: "https://goosebumps.fandom.com/wiki/List_of_Goosebumps_books?file=Night_of_the_Living_Dummy_(Cover).jpg", authors: [a1])
b5 = Book.create(title: "The Alchemist", publication_year: 1988, pages: 129, cover_image: "https://prodimage.images-bn.com/pimages/9780062355300_p0_v1_s550x406.jpg", authors: [a4])
b6 = Book.create(title: "Harry Potter & the Sorcerer's Stone", publication_year: 1997, pages: 293, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51HSkTKlauL._SX346_BO1,204,203,200_.jpg", author: [a5])
b7 = Book.create(title: "Ender's Game", publication_year: 1985, pages: 324, cover_image: "https://en.wikipedia.org/wiki/Ender%27s_Game#/media/File:Ender%27s_game_cover_ISBN_0312932081.jpg", authors: [a6])
b8 = Book.create(title: "Harry Potter & the Prisoner of Azkaban", publication_year: 1999, pages: 435, cover_image: "https://www.scholastic.com/content5/media/products/65/9780439136365_mres.jpg", authors: [a5])
b9 = Book.create(title: "The Signal and the Noise", publication_year: 2015, pages: 233, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51NDG49sWcL._SX324_BO1,204,203,200_.jpg", authors: [a8])
b10 = Book.create(title: "Python for Data Analysis", publication_year: 2017, pages: 233, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51cUNf8zukL._SX379_BO1,204,203,200_.jpg", authors: [a9,a10])
b11 = Book.create(title: "Orientalism", publication_year:1979, pages:197, cover_image: "https://upload.wikimedia.org/wikipedia/en/thumb/5/50/Orientalism%2C_first_edition.jpg/220px-Orientalism%2C_first_edition.jpg", authors: [a5,a10])



r1 = b1.reviews.create(username: "whiner",title: "Beware: Small Print",rating: 3,review_text: "I'm used to seeing Large Print featured as a plus for people with vision problems. This book needs to be clearly identified as Small Print. I understand and appreciate the technology of producing economical editions of out-of-copyright books, but buyers should be warned that books like this may require the use of a magnifying glass.")
r2 = b2.reviews.create(username: "Alexander",title: "Insightful, practical, and colorful. Perspective from a biased reviewer.",rating: 5,review_text: "Data Smart is none of these. Unlike Moneyball books, Data Smart contains enough practical information to actually start performing analyses. Unlike most textbooks, it doesn't get bogged down in mathematical notation. And unlike books about R or the distributed data blah-blah du jour, all the examples use good old Microsoft Excel. It's geared toward competent analysts who are comfortable with Excel and aren't afraid of thinking about problems in a mathematical way. It's goal isn't to revolutionize your business with million-dollar software, but rather to make incremental improvements to processes with accessible analytic techniques.")
r3 = b2.reviews.create(username: "BookGirl1",title: "Great Book, Lousy References",rating: 4,review_text: "I would go as far as to say that the book is brilliant. First, a drop about me from the standpoint of this book. I have been an IT professional for many years specializing in programming, database, and MS Office add-ons. Part of my job entails self enrichment, that is, expand my working knowledge in areas potentially important for my job. I chose Foreman's book to help with this task for a number of reasons: a) Data Science is a hot area and my company does have a Data Science group, b) I have lots of data experience under my belt - I felt that it would be nice for once to get some useful information from the data, and c) I have a really good Excel background - so I figured that Foreman's approach would be perfect for me - little did I know that I would seriously add to my Excel bag of tricks.")
r4 = b3.reviews.create(username: "BookGirl1",title: "A gift. Much appreciated. As described. Thanks ...",rating: 5,review_text: "A gift. Much appreciated. As described. Thanks.")
r5 = b3.reviews.create(username: "I'm a reader",title: "Hundreds of typos in the math. AVOID THIS BOOK!",rating: 1,review_text: "I'm giving this 1 star because of all the typos. The typos are in the math, making you stumble and feel dumb for not getting it, until you realize there is a typo after mentally trying various corrections to see if one of them makes the answer work out. Oh... there's the typo! I d i o t s!")
r6 = b3.reviews.create(username: "Book Worm",title: "Intimidating, yet rewarding comprehensive book.",rating: 5,review_text: "This book is truly a work of art. From his detailed to general knowledge about the history of mathematics, he gives the advanced mathematician an opportunity to see through the eyes of the great. This is not for beginners though. Even around mathematics majors and extremely high level scientists, many flee from the area when I pull this book out. It's thick and intimidating, but if you can sit and read parts of it at a time, it's greatly rewarding.")
r7 = b4.reviews.create(username: "S. Lopez",title: "Love R.L. Stine", review_rating: 5, review_text: "We read the first one together and plan on reading all of them, in order. My daughter is only 6 but is mature enough to handle any of the scariness she comes across. I recommend that parents read it with their kids to see if they would be able to handle some of the things discussed (nothing like Fear Street novels). Some kids may not be into (mild) horror and may get scared, so proceed with caution if under 8 (as recommended).")
r8 = b5.reviews.create(username: "bill berrigan", title: "Such an inspiring message!", review_rating: 5, review_text: "Great read! This book is one of the most influential books I've ever read and I liked how it was a story about an adventure, but also incorporated spirituality and self-improvement. I would most definitely recommend this book to a friend or anyone looking for clarity throughout their life journey.")
r9 = b6.reviews.create(username: "Albert G. Handelman", title: "A page turner, fun, nothing transcendent", review_rating: 4, review_text: "This was a fun and very fast read. I believe it was originally written for a younger audience, and it shows, with a lot of transparently silly names for people, places and things. There is a lot of detail in some aspects, almost none in others. As escapist fantasy work goes, this is better than most, but I'm not sure I'll read the rest of the series (even though it is set up to encourage exactly that).")
r10 = b7.reviews.create(username: "Bicycle Walrus", title: "Watch the Movie - Leave the Book Behind", review_rating: 2, review_text: "The author inserts bits and pieces of his own prejudice into the book that serves no purpose other than to stroke his own ego. He paints a picture of a cutthroat world in which women are inferior. The author's narrow minded world view did an incredible disservice to the single redeeming factor about this book.")
r11 = b8.reviews.create(username: "LunarEclipse", title: "Amazing Books", review_rating: 5, review_text: "I love all of the Harry Potter novels, but this one is by far my favorite! From the very first time I read it as a 7 year old (when the book first came out in 1999) I loved the change of pace from the other books in the series - for once, Lord Voldemort is not the main antagonist, and instead it's Sirius Black - or at least so we think!")
r12 = b8.reviews.create(username: "Andrew J.", title: "Lord of Rings was better!", review_rating: 1, review_text: "Harry potter is for kids. I'm an adult and I like Lord of the Rings. Legolis is hott! He is bae! I think JK Rowling is an imposter of an author and Tolkien is far superior!")
r13 = b9.reviews.create(username: "Book Worm",title: "Statistics in Context + Important Key Takeaways",rating: 4,review_text: "The author Nate Silver does a great job weaving more technical statistical concepts in context early in the book, so as not to lose readers early on. However I thought this would lead to more a detailed technical discussion later on, which the author said it would, but it never really transpired. Instead he kept to analogies and keeping the science of prediction in context. Which there's really nothing wrong with, if you're someone looking for that ... just not exactly what I wanted or expected.")
r14 = b10.reviews.create(username: "Alexander",title: "less than what I had hoped",rating: 3,review_text: "This book falls somewhere between a manual page providing one example per function and a cookbook, tending more toward the former. Examples are dry and most are constructed using random data. There is very little in the way of practical use cases. I bought the book hoping to get some inspiration for using numpy and/or pandas for some types of analyses I find myself doing, but that didn't happen. Probably I've gathered enough overview that I now can put together useful queries that will provide useful hits on Stack Exchange. I wish I had better to say.")
r15 = b11.reviews.create(username: "I'm a reader",title: "Painful to read, only an academic could tolerate this",rating: 2,review_text: "Horribly painful to read. His thesis is clear from the introduction. Three hundred pages of documentation for the thesis is excessive. This is ivory tower gum flapping. You will get more from reading other reader's summaries and analysis, rather than suffering thru this on your own. I had to read it for class, otherwise I never would have. Read the summaries you can find elsewhere and you'll get the gist. Don't torture yourself. Nonetheless, his point is valid and insightful, just drowned in excessive detail and support. Just take his word for it and save yourself the hours required.")
