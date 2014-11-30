require './spec/spec_helper'
require_relative 'helpers/session'
include SessionHelpers

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
  sign_up(name="giorgia", username = "gio", email_su = "gio@gio", password_su = "yoyo", password_confirmation = "yoyo")
  expect(page).to have_content("Welcome to Chitter")
  expect(current_path).to eq('/user/new')
	expect(page).to have_content("Welcome #{name}")
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
  sign_up(name = "giorgia", username = "gio", email_su = "gio@gio", password_su = "yoyo", password_confirmation = "yoyo") 
  expect(page).not_to have_content("Welcome, giorgia")
  expect(page).to have_content("Welcome to Chitter")
	expect(page).to have_content("Email is already taken")
end

Given(/^That I have already registered$/) do
	visit '/'
	expect(page).not_to have_content("Welcome giorgia")
	User.create(:name => 'giorgia', username:'gio', :email=>'gio@gio', :password => "yoyo", :password_confirmation => "yoyo")
	sign_in('gio@gio', 'yoyo')
	expect(page).to have_content("Welcome to Chitter")
	expect(page).to have_content("Welcome giorgia")
end

When(/^I type my name in the form$/) do
	visit '/'
	User.create(:name => 'giorgia', username:'gio', :email=>'gio@gio', :password => "yoyo", :password_confirmation => "yoyo")
	sign_in('gio@gio', 'yoyo')
	expect(page).to have_content("Welcome to Chitter")
	expect(page).to have_content("Welcome giorgia")
end

Then(/^I should be able to log in$/) do
	visit '/session/new'
end

Given(/^that I have been signed in$/) do
	visit '/'
	User.create(:name => 'giorgia', username:'gio', :email=>'gio@gio', :password => "yoyo", :password_confirmation => "yoyo")
	sign_up(name = "giorgia", username = "gio", email_su = "gio@gio", password_su = "yoyo", password_confirmation = "yoyo") 
	sign_in('gio@gio', 'yoyo')
	expect(page).to have_content("Welcome giorgia")
end

When(/^I sign out$/) do
	click_button "Sign Out"
	expect(current_path).to eq('/')
	expect(page).to have_content("You have signed out - Bye!")
	expect(page).not_to have_content("Welcome giorgia")
end

Then(/^I am not logged in anymore$/) do
#   I can only see my posts
end





































 