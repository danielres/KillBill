Feature: Index page

  As the author of the invoices
  I want to visit the index page
  In order to see the list of invoices already made

  Background:
    Given 3 invoices

  Scenario: The author visits the index page and sees the list of invoices
    When  I am on the homepage
    Then  I should see 3 invoices
