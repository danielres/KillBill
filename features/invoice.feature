Feature: Generate an invoice with activvities and totals


  As a freelance
  I want to create an invoice with activities and totals
  In order to charge for my services


  Background:

  Scenario: A user reads the total hours worked on an invoice with two activities
    Given an invoice with number "2013012"
    And   an activity "yawning" counting 32.5 hours for the invoice "2013012"
    And   an activity "snoring" counting 11.1 hours for the invoice "2013012"
    Then  the total hours for invoice "2013012" should be 43.6

  Scenario: A user reads how much he is charged, without and with VAT
    Given an invoice "2013013" with VAT: 21%, hourly rate: 56
    And   an activity "yawning" counting 2 hours for the invoice "2013013"
    And   an activity "snoring" counting 3.1 hours for the invoice "2013013"
    Then  the total charged for invoice "2013013" without taxes should be 285.60
    And   the taxes for invoice "2013013" should be 59.98
    And   the total charged for invoice "2013013" with taxes should be 345.58


