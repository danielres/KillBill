Feature: Generate an invoice with activvities and totals


  As a freelance
  I want to create an invoice with activities and totals
  In order to charge for my services


  Background:

  Scenario: Generate an invoice with activities and total hours
    Given an invoice with number "2013012"
    And   an activity "yawning" counting 32.5 hours for the invoice "2013012"
    And   an activity "snoring" counting 11.1 hours for the invoice "2013012"
    Then  the total hours for invoice "2013012" should be 43.6

