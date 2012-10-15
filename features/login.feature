@javascript
Feature: Login
  In order to be a user,
  I should be able to login.

  Background:
    Given I am signed in with provider "Facebook"
    And I go to the logout page
    And I am on the homepage
    And I should see the login link

  Scenario: I login
    When I click on the login link
    Then I should see the logout link

  Scenario: I logout
    Given I click on the login link
    When I click on the logout link
    Then I should see the login link
