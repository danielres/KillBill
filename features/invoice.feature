Feature: Generate an invoice with activvities and totals


  As a freelance
  I want to create an invoice with activities and totals
  In order to charge for my services


  Background:

  Scenario: A user reads the total hours worked on an invoice with two activities
    Given an invoice with number 12
    And   an activity "yawning" counting 32.5 hours for the invoice 12
    And   an activity "snoring" counting 11.1 hours for the invoice 12
    Then  the total hours for invoice 12 should be 43.6

  Scenario: A user reads how much he is charged, without and with VAT
    Given an invoice with number 13, VAT: 21%, hourly rate: 56
    And   an activity "yawning" counting 2 hours for the invoice 13
    And   an activity "snoring" counting 3.1 hours for the invoice 13
    Then  the total charged for invoice 13 without taxes should be 285.60
    And   the taxes for invoice 13 should be 59.98
    And   the total charged for invoice 13 with taxes should be 345.58


