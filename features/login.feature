Feature: Login
  In order to be a user,
  I should be able to login.

  Background:
    Given I am on the blog page
    And I am logged out
    And I am on the blog page

  Scenario: I login as an admin
    Given I am signed in with provider "Facebook" as Admin Test
    When I click on the login link
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
    When I click on the login link
    And I click on the logout link
    Then I should see the login link
    And I should see the logout message

  Scenario: I visit a protected page while logged out
    Given I am signed in with provider "Facebook"
    And I am logged out
    When try to visit the user admin page
    Then I should see the forbidden message

  Scenario: I visit a protected page as an editor
    Given I am signed in with provider "Facebook" as Editor Test
    When I log in
    And I try to visit the user admin page
    Then I should see the forbidden message

  Scenario: I visit a protected page as an editor
    Given I am signed in with provider "Facebook" as Admin Test
    When I log in
    And I try to visit the user admin page
    Then I should see the forbidden message
