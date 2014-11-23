Feature: In order to share info with my friends
As a social person
In order to be up-to-date
I want to use Chitter

Scenario: Signing up
Given I am on the homepage
When my password matches the password confirmation
Then I see my page


Scenario: Signing up
Given I am on the homepage
When my password DOES NOT match the password confirmation
Then I see an error

Scenario: Signing up
Given I am on the hompage
When the email I have inserted already exists in the database
Then I see an error