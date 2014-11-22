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
  sign_up(name = "fff", username = "fff", email = "ff@fff", password = "ffff", password_confirmation = "ffff")
	click_button "Sign Up"
	expect(page).to have_content("Welcome to Chitter")
	 expect(current_path).to eq('/user/new')
	expect(page).to have_content("Welcome fff")
end

When(/^my password DOES NOT match the password confirmation$/) do
  visit "/"
  sign_up(name = "giorgia", username = "gio", email = "gio@gio", password = "yoyo", password_confirmation = "niiu")
	click_button "Sign Up"
	expect(page).to have_content("Sorry, your passwords don't match")
end

Then(/^I see the same page$/) do
  pending # express the regexp above with the code you wish you had
end


def sign_up(name = "giorgia", username = "gio", email = "gio@gio", password = "yoyo", password_confirmation = 'yoyo')
	fill_in 'name', :with => name
	fill_in 'username', :with => username
	fill_in 'email', :with => email
	fill_in 'password', :with => password
	fill_in 'password_confirmation', :with => password_confirmation
end
 