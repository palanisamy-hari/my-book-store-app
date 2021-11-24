Feature: End to End functionality

  @system_test @test_case_10
  Scenario: Test end to end shopping application
    Given I open homepage
    When I click on sign up link
    And I fill the user details
    And I set the "8" length long password for the account
    And I click on "sign_up_button" on signup page

    And I open the books page
    And I add "2" books to the cart

    And I go to cart page
    And I click checkout

    And I enter payment information
    And I click buy now
    And I click on "logout" button on home page