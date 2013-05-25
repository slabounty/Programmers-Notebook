Given /^I am a valid user$/ do
  @user = User.create!(email: 'user@test.com', password: 'mysecret', password_confirmation: 'mysecret', name: 'Bob Johnson')
end

Given /^I am on the home page$/ do
  visit signin_path
end

Given /^I click the sign up button$/ do
  click_link('Sign up now!')
end

Given /^I enter valid user information$/ do
  fill_in 'Name', :with => 'Bukka White'
  fill_in 'Email', :with => 'bwhite@test.com'
  fill_in 'Password', :with => 'bluesman'
  fill_in 'Confirmation', :with => 'bluesman'
  click_button('Create my account')
end

Then /^I should signed up and logged in$/ do
  page.should have_content("Welcome to the Programmer's Notebook")
  page.should have_content("Bukka White")
end


Then /^I should be able to login$/ do
  visit signin_path
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => 'mysecret'
  click_button('Sign in')
end
Then /^I should be logged in$/ do
  page.should have_content("Sign out")
end

And /^I am logged in$/ do
  visit signin_path
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => 'mysecret'
  click_button('Sign in')
end

Then /^I should be able to logout$/ do
  click_link('Sign out')
end

Then /^I should be logged out$/ do
  page.should have_content("Sign in")
end
