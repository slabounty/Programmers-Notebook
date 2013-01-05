Given /^I go to the root page$/ do
  visit root_path
end

Then /^I should see the welcome message$/ do
  page.should have_content "This is the home page"
end

