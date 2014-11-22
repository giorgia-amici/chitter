require './spec/spec_helper'

User.create(:name => 'giorgia',
	                :username => 'gio',
  								:email => 'gio@gio',
  								:password => 'yoyo')

Given(/^I am on the homepage$/) do
	visit "/"
	expect(page).to have_content("Welcome to Chitter")
end

When(/^I sign up$/) do
	visit "/"
	fill_in 'name', :with => 'giorgia'
	fill_in 'username', :with => 'gio'
	fill_in 'email', :with => 'gio@gio' 
	fill_in 'password', :with => 'yoyo'
	click_button "Sign Up"

end

Then(/^I should see my personal page$/) do
	#where do you get directed?
end