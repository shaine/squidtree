Feature: Layout
  In Order To enjoy the website,
  I should be able to navigate its layout

  @wip
  Scenario: I visit the homepage
    When I go to the homepage
    Then I should see 21 discoveries
    And I should see 3 recent comments
    And I should see the search box

  @wip
  Scenario: I view all discoveries
    When I visit the discoveries page
    Then I should see 41 discoveries
    And I should not see the discoveries sidebar
    And I should not see the search box

  @javascript @wip
  Scenario: I view more discoveries
    When I go to the homepage
    Then I should see 21 discoveries
    When I view more discoveries
    Then I should see 41 discoveries
    When I view more discoveries
    Then I should see 61 discoveries
    When I view more discoveries
    Then I should see 81 discoveries

  @javascript
  Scenario: I view all months in the archive
    When I view all archive months
    Then I should see old archive months

  @allow-rescue
  Scenario: I visit a bad URL
    When I visit a bad URL
    Then I should see the 404 message
