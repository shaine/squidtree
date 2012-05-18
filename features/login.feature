Feature: Authorization System
  In Order to interact with the website
  I Should be able to login
  As a Facebook user

  @omniauth_test_success
  Scenario: A user successfully signs in with Facebook
    When I go to the login page
    Then I should see "Login successful."

  @omniauth_test_failure
  Scenario: A user unsuccessfully signs in with Facebook
    When I go to the login page
    Then I should see "Failed."
