require './spec/spec_helper'

before(:each) do
	User.create(:name => 'giorgia',
	                :username => 'gio',
  								:email => 'gio@gio',
  								:password => 'yoyo',
  								:password_confirmation => 'yoyo')
end

Given(/^I am on the homepage$/) do
	visit "/"
	expect(page).to have_content("Welcome to Chitter")
end

When(/^my password matches the password confirmation$/) do
	visit "/"
  sign_up
  expect(page).to have_content("Welcome to Chitter")
	expect(page).to have_content("Welcome giorgia")
end

When(/^my password DOES NOT match the password confirmation$/) do
  visit "/"
  sign_up(name = "giorgia", username = "gio", email_su = "gio@gio", password_su = "yoyo", password_confirmation = "nigygiiu") 
  expect(page).not_to have_content("Welcome, giorgia")
  expect(page).to have_content("Welcome to Chitter")
	expect(page).to have_content("Sorry, your passwords don't match")
end

Given(/^I am on the hompage$/) do
	visit '/'
	expect(page).to have_content("Welcome to Chitter")
end

When(/^the email I have inserted already exists in the database$/) do
	visit '/'
	User.create(:name => 'giorgia', username:'gio', :email=>'gio@gio', :password => "yoyo", :password_confirmation => "yoyo")
  sign_up(name = "giorgia", username = "gio", email_si = "gio@gio", password_si = "yoyo", password_confirmation = "yoyo") 
  expect(page).not_to have_content("Welcome, giorgia")
  expect(page).to have_content("Welcome to Chitter")
	expect(page).to have_content("Email is already taken")
end

# Given(/^That I have already registered$/) do
# 	visit '/sessions/new'
# 	expect(page).not_to have_content("Welcome giorgia")
# 	sign_in('gio@gio', 'yoyo')
# 	expect(page).to have_content("Welcome to Chitter")
# end

When(/^I type my name in the form$/) do

end

Then(/^I should be able to log in$/) do
end










def sign_up(name = "giorgia", username = "gio", email = "gio@gio", password = "yoyo", password_confirmation = 'yoyo')
	fill_in 'name', :with => name
	fill_in 'username', :with => username
	fill_in 'email_su', :with => email
	fill_in 'password_su', :with => password
	fill_in 'password_confirmation', :with => password_confirmation
	click_button "Sign Up"
end

def sign_in(email, password)
	fill_in 'email_si', :with => email
	fill_in 'password_si', :with => password
	click_button "Sign In"
end
































 