Feature: In order to share info with my friends
As a social person
In order to be up-to-date
I want to use Chitter

Scenario: Signing up
Given I am on the homepage
When my password matches the password confirmation


Scenario: Signing up
Given I am on the homepage
When my password DOES NOT match the password confirmation

Scenario: Signing up
Given I am on the hompage
When the email I have inserted already exists in the database


Scenario: Signing in
Given That I have already registered 
When I type my name in the form
Then I should be able to log in

Scenario: Signing out
Given that I have been signed in
When I sign out
Then I am not logged in anymore