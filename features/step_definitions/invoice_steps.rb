require_relative "../../models/invoice"
require_relative "../../models/invoice_store"
require 'ostruct'

FLOAT = Transform /^[0-9]*\.?[0-9]+$/ do |float|
  float.to_f
end

NUMBER = Transform /^[0-9]+$/ do |number|
  number.to_i
end

INVOICE = Transform /^invoice ([0-9]+)$/ do |number|
  @invoice_store.find( number.to_i ) || @invoice_store.new_invoice( number.to_i )
end

INVOICE_WITH_PARAMS = Transform /^invoice ([0-9]+) with (.*)$/ do |number, params|
  params = Hash[ params.split(', ').map{ |e| e.split(': ') } ]
  @invoice_store.new_invoice number.to_i,
              vat:         params["vat"].to_f,
              hourly_rate: params["hourly_rate"].to_f
end

Given(/^an (#{INVOICE}|#{INVOICE_WITH_PARAMS})$/) do |invoice|
  invoice
end

Given(/^an activity lasting (#{FLOAT}) hours added to (#{INVOICE})$/) do |hours, invoice|
  invoice.add_entry OpenStruct.new( hours: hours )
end

Then(/^the total hours in (#{INVOICE}) should be (#{FLOAT})$/) do |invoice, total_hours|
  expect( invoice.total_hours ).to eq total_hours
end

Then(/^the total charged in (#{INVOICE}) without taxes should be (#{FLOAT})$/) do |invoice, amount|
  expect( invoice.ex_vat_total ).to eq amount
end

Then(/^the vat charged in (#{INVOICE}) should be (#{FLOAT})$/) do |invoice, amount|
  expect( invoice.vat_total ).to eq amount
end

Then(/^the total charged in (#{INVOICE}) with taxes should be (#{FLOAT})$/) do |invoice, amount|
  expect( invoice.inc_vat_total ).to eq amount
end