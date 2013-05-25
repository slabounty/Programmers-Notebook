Feature: Sign Up and Login Feature

  Scenario: As a user, I should be able to sign up for an account
    Given I am on the home page
    And I click the sign up button
    And I enter valid user information
    Then I should signed up and logged in

  Scenario: As a valid user, I should be able to login
    Given I am a valid user
    Then I should be able to login
    And I should be logged in

  Scenario: If I am logged in, I should be able to log out
    Given I am a valid user
    And I am logged in
    Then I should be able to logout
    And I should be logged out
