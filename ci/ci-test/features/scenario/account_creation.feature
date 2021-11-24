Feature: Login functionality on Sinatra ruby app

  @system_test @test_case_1
  Scenario: Register account
    Given I open homepage
    When I click on sign up link
    And I fill the user details
    And I set the "8" length long password for the account
    And I click on "sign_up_button" on signup page
    Then I land on the "User Profile" page
    And I click on "logout" button on home page

  @system_test @test_case_2
  Scenario: Login into an existing customer
    Given I open homepage
    When I click on "sign_in" button on home page
    And I fill the user details for "existing" customer
    And I click on "sign_in" button on sign page
    Then I land on the "User Profile" page
    And I click on "logout" button on home page

  @system_test @test_case_3
  Scenario: Login as an non existing customer
    Given I open homepage
    When I click on "sign_in" button on home page
    And I fill the user details for "non-existing" customer
    And I click on "sign_in" button on sign page
    Then I should see the error message "Username does not exist, please create a new account" for "wrong-username"

  @system_test @test_case_4
  Scenario: Login as an existing customer with incorrect password
    Given I open homepage
    When I click on "sign_in" button on home page
    And I fill the user details for "wrong-password" customer
    And I click on "sign_in" button on sign page
    Then I should see the error message "Password did not match, please re-try" for "wrong-password"

