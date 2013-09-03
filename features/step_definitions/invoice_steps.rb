require_relative "../../models/invoice"

class Activity
  attr_reader :name, :hours
  def initialize name, hours
    @name  = name
    @hours = hours
  end
end

Given(/^an invoice with number "(.*?)"$/) do |invoice_number|
  @invoice = Invoice.new invoice_number
end


Given(/^an activity "(.*?)" counting (.+) hours for the invoice "(.*?)"$/) do |name, hours, invoice_number|
  activity = Activity.new name, hours
  @invoice.add_entry activity
end

Then(/^the total hours for invoice "(.*?)" should be (.*)$/) do |invoice_number, total_hours|
  @invoice.total_hours.to_f.should eq total_hours.to_f
end

