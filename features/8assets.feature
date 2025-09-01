Feature: existing assets

Background:
  Given I have a checking asset
    * it has a compound income
    * it has a medium outgo
    * it has a large outgo
  And I have a savings asset
    * it has a medium income
    * it has a large income
  When I am on the home page

Example: total net
  Then the asset amount should be compound

Example: list assets
  Then I should see 2 assets

Example: with their links
  Then the link to Checking should be enabled
    And the link to Savings should be enabled

Example: with their nets
  Given it has a small income
  When I am on the home page
  Then the checking amount should be small
    And the savings amount should be compound

Example: list children
  When I go to the checking page
  Then I should see 1 income
    And I should see 2 outgoes
    And the unreconciled amount should be small

Example: transfer page shows nets
  Given it has a small income
  When I go to the transfer page
  Then the checking amount should be small
    And the savings amount should be compound

Example: transfer between assets success
  When I go to the transfer page
    And I transfer a large amount
  Then I should see a notice

Example: transfer between assets failure
  When I go to the transfer page
    And I transfer a compound amount
  Then I should see an alert

Example: transfer between same asset failure
  When I go to the transfer page
    And I give it a small amount
  Then I should see an alert

Example: transfer between assets tomorrow
  When I go to the transfer page
    And I enter tomorrow
    And I transfer a large amount
    And I go to the checking page
  Then the date should be tomorrow
