Feature: existing debts

Background:
  Given I have a visa debt
    * it has a compound charge
    * it has a medium discharge
    * it has a large discharge
  And I have a itunes debt
    * it has a large charge
    * it has a large discharge
  When I am on the home page

Example: total net
  Then the debt amount should be small

Example: list debts
  Then I should see 2 debts

Example: with their links
  Then the link to Visa should be enabled
    And the link to iTunes should be enabled

Example: with their nets
  Given it has a compound charge
  When I am on the home page
  Then the Visa amount should be small
    And the iTunes amount should be compound

Example: list children
  When I go to the Visa page
  Then I should see 1 charge
    And I should see 2 discharges
    And the unreconciled amount should be small

Example: payments page shows nets
  Given it has a compound charge
  When I go to the payment page
  Then the Visa amount should be small
    And the iTunes amount should be compound

Example: payments between debts success
  When I go to the payment page
    And I pay a large amount
  Then I should see a notice

Example: payments between same debt failure
  When I go to the payment page
    And I give it a small amount
  Then I should see an alert
