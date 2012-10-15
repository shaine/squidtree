Feature: Blog
  In Order To be entertained by the site,
  I should be able to read a blog

  Background:
    Given I go to the blog
    Then I should be on the blog

  Scenario: I visit the blog
    When I go to the blog
    And I should see 10 posts
    And I should see 21 discoveries
    And I should see 3 recent comments

  @wip @javascript
  Scenario: I view more discoveries
    When I click the View More Discoveries link
    Then I should see 41 discoveries
    When I click the View More Discoveries link
    Then I should see 61 discoveries
    When I click the View More Discoveries link
    Then I should see 81 discoveries
