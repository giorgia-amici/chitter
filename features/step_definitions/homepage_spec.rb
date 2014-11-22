Given(/^I am on the homepage$/) do
	visit '/'
	expect(page).to have_content("Welcome to Chitter")
end

When(/^I sign up$/) do
	visit '/'
	fill_in 'username'
	fill_in 'password'
	click_button 'Sing Up'
end

Then(/^I should see my personal homepage$/) do
end