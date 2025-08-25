Feature: manipulating an debt

Example: New debt title
  When I go to the new debt page
  Then the title should be 'IDNAB: New Debt'

Example: show debt title
  Given I have a Visa debt
  When I go to the Visa page
  Then the title should be 'IDNAB: Visa Debt'

Example: create new success without memo
  When I go to the new debt page
    And I give it the name Visa
  Then I should see a notice

Example: create new success with memo
  When I go to the new debt page
    And I enter the memo #123-456-7890
    And I give it the name Visa
  Then I should see a notice

Example: create new memo permitted
  When I go to the new debt page
    And I enter the memo #123-456-7890
    And I give it the name Visa
    And I go to the Visa page
  Then I should see "#123-456-7890"

Example: create new failure
  Given I have a Visa debt
  When I go to the new debt page
    And I give it the name Visa
  Then I should see an alert
    And I should see an error

Example: edit debt title
  Given I have a Visa debt
  When I go to the edit Visa debt page
  Then the title should be 'IDNAB: Edit Visa Debt'

Example: edit Visa success
  Given I have a Visa debt
  When I go to the edit Visa debt page
    And I give it the name DebitCard
  Then I should see a notice

Example: edit Visa failure
  Given I have a Visa debt
    And I have an iTunes debt
  When I go to the edit Visa debt page
    And I give it the name iTunes
  Then I should see an alert
    And I should see an error

Example: delete debt title
  Given I have a Visa debt
  When I go to the delete Visa debt page
  Then the title should be 'IDNAB: Delete Visa Debt'

Example: delete success
  Given I have a Visa debt
  When I go to the delete Visa debt page
    And I confirm
  Then I should see an alert

Example: delete abort
  Given I have a Visa debt
  When I go to the delete Visa debt page
    And I change my mind
  Then I should see a notice

Example: debt name on home page
  Given I have a Visa debt
  When I am on the home page
  Then I should see "Visa"

Example: debt memo not on home page
  Given I have a Visa debt
    And the debt has the memo BofA
  When I am on the home page
  Then I should NOT see "BofA"

Example: debt name on debt page
  Given I have a Visa debt
  When I go to the Visa page
  Then I should see "Visa"

Example: debt memo on debt page
  Given I have a Visa debt
    And the debt has the memo BofA
  When I go to the Visa page
  Then I should see "BofA"

Example: Payment title
  When I go to the payment page
  Then the title should be 'IDNAB: New Payment'

Example: Reconciled amount
  Given I have a Visa debt
    And it has a small charge
  When I go to the Visa page
  Then the reconciled amount should be zero

Example: Unreconciled amount
  Given I have a Visa debt
    And it has a small charge
  When I go to the Visa page
  Then the unreconciled amount should be small

Example: reconcile charge
  Given I have a Visa debt
    And it has a small charge
  When I go to the Visa page
    And I press Reconcile
  Then the reconciled amount should be small

Example: reconcile discharge
  Given I have a Visa debt
    And it has a small discharge
  When I go to the Visa page
    And I press Reconcile
  Then the unreconciled amount should be zero

Example: unreconcile charge
  Given I have a Visa debt
    And it has a small charge
  When I go to the Visa page
    And I press Reconcile
    And I press Unreconcile
  Then the reconciled amount should be zero

Example: unreconcile discharge
  Given I have a Visa debt
    And it has a small reconciled discharge
  When I go to the Visa page
    And I press Unreconcile
  Then the reconciled amount should be zero
