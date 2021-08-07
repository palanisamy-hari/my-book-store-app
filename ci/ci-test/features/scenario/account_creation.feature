Feature: Login functionality on Sinatra ruby app

  @system_test @test_case_1
  Scenario: Register account
    Given I open homepage
    When I click on "sign up" button
    And I fill the user details
    And I set the 8 length long password for the account
    And I click on "create user" button
    Then I land on the "welcome" page
    And I click on "Log out" button

  @system_test @test_case_2
  Scenario: Login into an existing customer
    Given I open homepage
    When I click on "login" button
    And I fill the user details for "existing" customer
    And I click on "login" button
    Then I land on the "welcome" page
    And I click on "Log out" button

  @system_test
  Scenario: Login as an non existing customer
    Given I open homepage
    When I click on "login" button
    And I fill the user details for "non-existing" customer
    And I click on "login" button
    Then I should see the error message "Username does not exist, please create a new account" for "wrong-username"

  @system_test
  Scenario: Login as an existing customer with incorrect password
    Given I open homepage
    When I click on "login" button
    And I fill the user details for "wrong-password" customer
    And I click on "login" button
    Then I should see the error message "Password did not match, please re-try" for "wrong-password"

