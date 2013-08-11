Feature: Index page

  As the author of the invoices
  I want to visit the index page
  In order to see the list of invoices already made

  Scenario: The author visits the index page and sees the list of invoices
    Given 3 invoices
    When  I am on the homepage
    Then  I should see 3 invoices

  Scenario: The author sees an invoice with basic details on the index page
    Given an invoice 2013003 with vat: 21, hourly_rate: 56, emit_date: 2013-08-05
    And   an activity lasting 10 hours added to invoice 2013003
    When  I am on the homepage
    Then  I should see 1 invoice
    And   I should see "2013003", "2013-08-05", "€560.00" within the invoice
