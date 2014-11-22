require './spec/spec_helper'

User.create(:name => 'giorgia',
	                :username => 'gio',
  								:email => 'gio@gio',
  								:password => 'yoyo',
  								:password_confirmation => 'yoyo')

Given(/^I am on the homepage$/) do
	visit "/"
	expect(page).to have_content("Welcome to Chitter")
end

When(/^my password matches the password confirmation$/) do
  sign_up
	click_button "Sign Up"
	expect(page).to have_content("Sorry, your passwords don't match")
end




def sign_up
	visit "/"
	fill_in 'name', :with => 'giorgia'
	fill_in 'username', :with => 'gio'
	fill_in 'email', :with => 'gio@gio' 
	fill_in 'password', :with => 'yoyo'
	fill_in 'password_confirmation', :with => 'yoyo'
end
# (name = "giorgia", username = "bubu", email = "gio@gio", password = "yoyo", password_confirmation = 'yoyo')