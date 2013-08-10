When(/^I visit the index page$/) do
  visit '/'
end

Then(/^I should see (\d+) invoices$/) do |qty|
  pending 'capybara/cucumber/sinatra not yet implemented'
end
