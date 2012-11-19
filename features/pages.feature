Feature: Layout
  In Order To enjoy the website,
  I should be able to navigate its layout

  Scenario: I visit the homepage
    When I go to the homepage
    Then I should see 20 discoveries
    And I should see 3 recent comments
    And I should see the search box

  Scenario: I view all discoveries
    When I visit the discoveries page
    Then I should see 60 discoveries
    And I should not see the discoveries sidebar
    And I should not see the search box

  @wip
  Scenario: I view more discoveries
    When I go to the homepage
    Then I should see 20 discoveries
    When I view more discoveries
    Then I should see 40 discoveries
    When I view more discoveries
    Then I should see 60 discoveries
    When I view more discoveries
    Then I should see 80 discoveries

  @javascript
  Scenario: I view all months in the archive
    When I go to the homepage
    And I view all archive months
    Then I should see old archive months

  @allow-rescue
  Scenario: I visit a bad URL
    When I visit a bad URL
    Then I should see the 404 message
