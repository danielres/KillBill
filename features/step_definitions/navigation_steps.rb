Then(/^I should see (\d+) invoices?$/) do |qty|
  expect( page ).to have_selector( ".invoice", count: qty )
end
