@javascript
Feature: Login
  In order to be a user,
  I should be able to login.

  Background:
    Given I am logged out
    And I am on the blog page

  @wip
  Scenario: I login as an admin
    Given I am signed in with provider "Facebook" as Admin Test
    When I click on the login link
    Then show me the page
    Then I should see the logout link

  Scenario: I login as an editor
    Given I am signed in with provider "Facebook" as Editor Test
    When I click on the login link
    Then I should see the logout link

  Scenario: I login as a whitelisted user
    Given I am signed in with provider "Facebook" as Whitelisted Test
    When I click on the login link
    Then I should see the logout link

  Scenario: I login as an anonymous user
    Given I am signed in with provider "Facebook" as Anonymous Test
    When I click on the login link
    Then I should see the logout link

  Scenario: I logout
    Given I am signed in with provider "Facebook"
    When I click on the logout link
    Then I should see the login link
    And I should see the logout message
