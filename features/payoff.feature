Feature: payoff debts from assets

Background:
  Given I have a checking asset
    * it has a large income
  Given I have a visa debt
    * it has a compound charge

Example: payoff success
  When I go to the payoff page
    And I payoff a large amount
  Then I should see a notice

Example: payoff failure
  When I go to the payoff page
    And I payoff a compound amount
  Then I should see an alert

Example: payoff yesterday
  When I go to the payoff page
    And I enter yesterday
    And I payoff a large amount
    And I go to the checking page
  Then the date should be yesterday
