require_relative "../../models/invoice"
require 'cucumber/rspec/doubles'

FLOAT = Transform /^[0-9]*\.?[0-9]+$/ do |float|
  float.to_f
end

NUMBER = Transform /^[0-9]+$/ do |number|
  number.to_i
end

INVOICE = Transform /^invoice ([0-9]+)$/ do |number|
  Invoice.find number.to_i
end

Given(/^an invoice with number (#{NUMBER})$/) do |number|
  @invoice = Invoice.new number
end

Given(/^an activity "(.*?)" counting (#{FLOAT}) hours for the (#{INVOICE})$/) do |name, hours, invoice|
  activity = stub name: name, hours: hours
  invoice.add_entry activity
end

Then(/^the total hours for (#{INVOICE}) should be (#{FLOAT})$/) do |invoice, total_hours|
  expect( invoice.total_hours ).to eq total_hours
end

Given(/^an invoice with number (#{NUMBER}), VAT: (#{NUMBER})%, hourly rate: (#{FLOAT})$/) do |number, vat, hourly_rate|
  Invoice.new number, vat: vat, hourly_rate: hourly_rate
end

Then(/^the total charged for (#{INVOICE}) without taxes should be (#{FLOAT})$/) do |invoice, amount|
  expect( invoice.ex_vat_total ).to eq amount
end

Then(/^the taxes for (#{INVOICE}) should be (#{FLOAT})$/) do |invoice, amount|
  expect( invoice.vat_total ).to eq amount
end

Then(/^the total charged for (#{INVOICE}) with taxes should be (#{FLOAT})$/) do |invoice, amount|
  expect( invoice.inc_vat_total ).to eq amount
end

Then(/^show me all invoices$/) do
  puts Invoice.all
end

Then(/^show me the invoice "(.*?)"$/) do |number|
  puts ( Invoice.find number ).inspect
end
