Feature: home page

Background:
  When I am on the home page

Example: Home title
  Then the title should be "INAB: Home"

Example: Home unless current
  Then the link to Home should be disabled

Example: Home link if not current
  When I follow New Asset
  Then the link to Home should be enabled

Example: Home shows net worth
  Then I should see 'Net'
    And the net amount should be zero

Example: Home shows assets total
  Then I should see 'Assets'
    And the asset amount should be zero

Example: Home shows debts total
  Then I should see 'Debts'
    And the debt amount should be zero
