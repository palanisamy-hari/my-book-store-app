Feature: End to End functionality

Feature: Shopping Cart and Purchase Functionality on Sinatra Ruby App

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
  Scenario: Add Items to the Cart
    Given I am logged in and on the "User Profile" page
    When I navigate to the "Products" page
    And I add items to the shopping cart
    Then I should see the items in my cart
    And the cart total should reflect the selected items

  @system_test @test_case_4
  Scenario: Remove Items from the Cart
    Given I am logged in and have items in the shopping cart
    When I navigate to the "Cart" page
    And I remove selected items from the cart
    Then the cart should be updated without the removed items
    And the cart total should reflect the remaining items

  @system_test @test_case_5
  Scenario: Proceed to Purchase
    Given I am logged in and have items in the shopping cart
    When I navigate to the "Cart" page
    And I click on the "Proceed to Purchase" button
    Then I should be on the "Purchase" page
    And I should see the selected items and total cost
    And I fill in the shipping and payment details
    And I click on the "Complete Purchase" button
    Then I land on the "Order Confirmation" page
    And I receive an order confirmation message

  @system_test @test_case_6
  Scenario: View Purchase History
    Given I am logged in
    When I navigate to the "Purchase History" page
    Then I should see a list of my previous purchases
    And I can click on each purchase to view details

      @system_test @test_case_7
  Scenario: Empty Cart
    Given I am logged in and have items in the shopping cart
    When I navigate to the "Cart" page
    And I click on the "Empty Cart" button
    Then the cart should be empty
    And the cart total should be zero

  @system_test @test_case_8
  Scenario: Apply Coupon Code
    Given I am logged in and have items in the shopping cart
    When I navigate to the "Cart" page
    And I enter a valid coupon code
    And I click on the "Apply Coupon" button
    Then the cart total should be updated with the discount
    And I should see a confirmation message for the applied coupon

  @system_test @test_case_9
  Scenario: View Product Details from Cart
    Given I am logged in and have items in the shopping cart
    When I navigate to the "Cart" page
    And I click on the product name or image in the cart
    Then I should be redirected to the product details page
    And I can view detailed information about the selected product

  @system_test @test_case_10
  Scenario: Cancel Purchase
    Given I am on the "Purchase" page with selected items
    When I click on the "Cancel Purchase" button
    Then I should be redirected to the "Cart" page
    And the cart should contain the previously selected items
    And the cart total should reflect the items before the purchase attempt

  @system_test @test_case_11
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