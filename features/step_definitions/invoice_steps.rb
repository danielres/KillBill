require_relative "../../models/invoice"
require 'cucumber/rspec/doubles'

CAPTURE_FLOAT = Transform /^[0-9]*\.?[0-9]+$/ do |float|
  float.to_f
end

Given(/^an invoice with number "(.*?)"$/) do |invoice_number|
  @invoice = Invoice.new invoice_number
end

Given(/^an activity "(.*?)" counting (.+) hours for the invoice "(.*?)"$/) do |name, hours, invoice_number|
  activity = stub( name: name, hours: hours )
  Invoice.find(invoice_number).add_entry activity
end

Then(/^the total hours for invoice "(.*?)" should be (.*)$/) do |invoice_number, total_hours|
   Invoice.find(invoice_number).total_hours.to_f.should eq total_hours.to_f
end

Given(/^an invoice "(.*?)" with VAT: (\d+)%, hourly rate: (\d+)$/) do |invoice_number, vat, hourly_rate|
  Invoice.new invoice_number, vat: vat,  hourly_rate:  hourly_rate
end

Then(/^the total charged for invoice "(.*?)" without taxes should be (#{CAPTURE_FLOAT})$/) do |invoice_number, amount|
  expect(  Invoice.find(invoice_number).ex_vat_total ).to eq amount
end

Then(/^the taxes for invoice "(.*?)" should be (#{CAPTURE_FLOAT})$/) do |invoice_number, amount|
  expect(  Invoice.find(invoice_number).vat_total ).to eq amount
end

Then(/^the total charged for invoice "(.*?)" with taxes should be (#{CAPTURE_FLOAT})$/) do |invoice_number, amount|
  expect(  Invoice.find(invoice_number).inc_vat_total ).to eq amount
end

Then(/^show me all invoices$/) do
  puts Invoice.all
end

Then(/^show me the invoice "(.*?)"$/) do |number|
  puts (Invoice.find number).inspect
end
