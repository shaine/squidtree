Feature: Site Navigation
  In Order To use the website
  I Should be able to visit its pages

  Scenario: I visit the homepage
    When I go to the homepage
    Then I should be on the homepage

  Scenario: I visit the blog
    When I go to the blog
    Then I should be on the blog
    And I should see 10 posts
    And I should see 20 discoveries
    And I should see 3 recent comments

  Scenario: I visit the portfolio page
    When I go to the portfolio page
    Then I should be on the portfolio page

  Scenario: I visit the about page
    When I go to the about page
    Then I should be on the about page

  Scenario: I visit the contact page
    When I go to the contact page
    Then I should be on the contact page
