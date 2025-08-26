Feature: manipulating an asset

Example: New asset title
  When I go to the new asset page
  Then the title should be 'BtB: New Asset'

Example: show asset title
  Given I have a checking asset
  When I go to the checking page
  Then the title should be 'BtB: Checking Asset'

Example: create new success without memo
  When I go to the new asset page
    And I give it the name Checking
  Then I should see a notice

Example: create new success with memo
  When I go to the new asset page
    And I enter the memo #123-456-7890
    And I give it the name Checking
  Then I should see a notice

Example: create new memo permitted
  When I go to the new asset page
    And I enter the memo #123-456-7890
    And I give it the name Checking
    And I go to the checking page
  Then I should see "#123-456-7890"

Example: create new failure
  Given I have a checking asset
  When I go to the new asset page
    And I give it the name Checking
  Then I should see an alert
    And I should see an error

Example: edit asset title
  Given I have a checking asset
  When I go to the edit checking asset page
  Then the title should be 'BtB: Edit Checking Asset'

Example: edit checking success
  Given I have a checking asset
  When I go to the edit checking asset page
    And I give it the name DebitCard
  Then I should see a notice

Example: edit checking failure
  Given I have a checking asset
    And I have a savings asset
  When I go to the edit checking asset page
    And I give it the name Savings
  Then I should see an alert
    And I should see an error

Example: delete asset title
  Given I have a checking asset
  When I go to the delete checking asset page
  Then the title should be 'BtB: Delete Checking Asset'

Example: delete success
  Given I have a checking asset
  When I go to the delete checking asset page
    And I confirm
  Then I should see an alert

Example: delete abort
  Given I have a checking asset
  When I go to the delete checking asset page
    And I change my mind
  Then I should see a notice

Example: asset name on home page
  Given I have a checking asset
  When I am on the home page
  Then I should see "Checking"

Example: asset memo not on home page
  Given I have a checking asset
    And the asset has the memo BofA
  When I am on the home page
  Then I should NOT see "BofA"

Example: asset name on asset page
  Given I have a checking asset
  When I go to the checking page
  Then I should see "Checking"

Example: asset memo on asset page
  Given I have a checking asset
    And the asset has the memo BofA
  When I go to the checking page
  Then I should see "BofA"

Example: Transfer title
  When I go to the transfer page
  Then the title should be 'BtB: New Transfer'

Example: Reconciled amount
  Given I have a checking asset
    And it has a small income
  When I go to the checking page
  Then the reconciled amount should be zero

Example: Unreconciled amount
  Given I have a checking asset
    And it has a small income
  When I go to the checking page
  Then the unreconciled amount should be small

Example: reconcile income
  Given I have a checking asset
    And it has a small income
  When I go to the checking page
    And I press Reconcile
  Then the reconciled amount should be small

Example: reconcile outgo
  Given I have a checking asset
    And it has a small reconciled income
    And it has a small outgo
  When I go to the checking page
    And I press Reconcile
  Then the unreconciled amount should be zero

Example: unreconcile income
  Given I have a checking asset
    And it has a small income
  When I go to the checking page
    And I press Reconcile
    And I press Unreconcile
  Then the reconciled amount should be zero

Example: unreconcile outgo
  Given I have a checking asset
    And it has a small income
    And it has a small reconciled outgo
  When I go to the checking page
    And I press Unreconcile
  Then the reconciled amount should be zero
