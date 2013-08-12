Feature: Invoice page

  As the author of the invoices
  I want to visit an invoice page
  In order to see the complete invoice

  Scenario: The author visits the page of an invoice and reads all its details
    Given an invoice 2013003 with vat: 21, hourly_rate: 56, emit_date: 2013-08-05
    And   an activity "Brogramming" lasting 10 hours added to invoice 2013003
    When  I am on the invoice 2013003 page
    And   I should see "2013003", "2013-08-05", "€560.00", "Brogramming", "10h", "€56.00", "€117.60", "677.60" within the invoice