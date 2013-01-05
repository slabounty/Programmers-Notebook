Feature: Salutation Header
  In order to be welcomed
  As a user
  I want to see a welcome message

  Scenario: There should be a welcome message
    Given I go to the root page
    Then I should see the welcome message
