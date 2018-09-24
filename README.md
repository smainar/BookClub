# Good Reads

Backend Module 2 paired Rails project, weeks 2 and 3

## Background and Description

This purpose of this application is for users to review books. The primary goal of this challenge is testing your ability to set up many-to-many relationships and accessing attributes through multiple models.

## Learning Goals for this Project

- creation of a basic Rails web application
- implementing basic MVC structure to your project
- save and retrieve data from a database
- display content on a web page with some very basic styling
- learning how to test your code effectively at a Controller and a Model level


## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- all controller and model code must be tested via feature tests and model tests, respectively
- must use some amount of HTML and CSS layout

## Not Required


## User Stories

```
User Story 1

As a Visitor,
When I visit a book index page,
I see all book titles in the database,
And each book title is a link to that book's show page.
```

```
User Story 2

As a Visitor,
When I visit a book show page,
I see the book title and a list of reviews for that book.
The review shown should include the text of the review, and user who wrote the review.
```

```
User Story 3

As a Visitor,
When I visit a book show page,
I also see a rating that each user gave the book as part of their review.

(rating will be a number between 1 and 5)
```

```
User Story 4

As a Visitor,
When I visit a book show page,
I see the average rating for that book.

(e.g "Average Rating: 3.5")
```

```
User Story 5

As a Visitor,
When I visit a book show page,
I see a heading that includes the highest rating for that book.

(e.g "Highest Rating: 4").
```

```
User Story 6

As a Visitor,
When I visit a book show page,
under the heading for highest rating,
I see the review text, and the name of the reviewer
that submitted that review.

(it's okay if the review is also listed again on the page later with all other reviews)
```

```
User Story 7

As a Visitor,
When I visit a book show page,
I see a header that includes the lowest rating for that book.

(e.g "Lowest Rating: 1")
```

```
User Story 8

As a User,
When I visit the book show page,
under the header for lowest rating,
I see the body of that review and the name of the reviewer
that submitted that review.

(it's okay if the review is also listed again on the page later with all other reviews)
```

## Extensions

If you finish your project early you are expected to attempt extension work.

```
TBD
```

## Rubric

Each paired team will have a rubric uploaded to [https://github.com/turingschool/ruby-submissions](https://github.com/turingschool/ruby-submissions)

### 1. Feature Completeness

* Exceeds Expectations: All features are correctly implemented along with one or more extensions
* Meets Expectations: All features defined in the assignment are correctly implemented and project is deployed
* Below Expectations: There are one or two features missing or incorrectly implemented and/or project is not fully deployed

### 2. Views

* Exceeds Expectations: Views show logical refactoring into layout(s), partials and helpers, with no logic present
* Meets Expectations: Views make use of layout(s), partials and helpers
* Below Expectations: Views don't make use of partials or show weak understanding of rendering templates

### 3. Controllers

* Exceeds Expectations: Controller code shows significant effort towards refactoring and pushing logic down the stack
* Meets Expectations: Controller code is generally well organized with three or fewer methods that need refactoring
* Below Expectations: There are many controller methods that should have been refactored

### 4. Models

* Exceeds Expectations: Models show excellent organization, refactoring, and appropriate use of Rails features
* Meets Expectations: Models show an effort to push logic down the stack, but need more internal refactoring
* Below Expectations: Models are somewhat messy and/or make poor use of Rails features

### 5. ActiveRecord

* Exceeds Expectations: Best choice ActiveRecord methods are used to solve each problem
* Meets Expectations: ActiveRecord is utilized wherever it can be. There is no Ruby where there should be ActiveRecord
* Below Expectations: Ruby is used to programatically solve problems where ActiveRecord could be used

### 6. Testing

* Exceeds Expectations: Project has a running test suite that exercises the application at multiple levels and utilizes excellent setup and teardown to maximum productivity and minimize code
* Meets Expectations: Project has a running test suite that covers all functionality and tests at multiple levels
* Below Expectations: Project has sporadic use of tests at multiple levels

### 7. Usability

* Exceeds Expectations: Project is highly usable and ready to deploy to customers
* Meets Expectations: Project is highly usable, but needs more polish before it'd be customer-ready
* Below Expectations: Project needs more attention to the User Experience, some views need to use a URL to visit them

### 8. Styling and Layout

* Exceeds Expectations: Project utilizes HTML and CSS to its fullest
* Meets Expectations: Project utilizes HTML and CSS but has some area for improvement
* Below Expectations: Project utilizes little or no HTML or CSS

### 9. Workflow

* Exceeds Expectations: Excellent use of branches, pull requests, peer and instructor code review, and a project management tool.
* Meets Expectations: Good use of branches, pull requests, peer and instructor code review, and a project management tool.
* Below Expectations: Sporadic use of branches, pull requests, and/or project management tool.
 
### 10. Documentation

* Exceeds Expectations: Excellent README which gives users an exemplary guide to the what your application is, how it's used, including screenshots, installation instructions, links to each project member's github, etc.
* Meets Expectations: A custom README is present and gives users an guide to what your application is about
* Below Expectations: This project is lacking a README
