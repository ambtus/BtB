Feature: manipulating a discharge

Background:
  Given I have a Visa debt

Example: create new success without memo
  When I go to the discharge page
    And I give it a small amount
  Then I should see a notice

Example: create new success with memo
  When I go to the discharge page
    And I enter the memo IRS
    And I give it a complex amount
  Then I should see a notice

Example: create new memo permitted
  When I go to the discharge page
    And I enter the memo IRS
    And I give it a complex amount
  Then I should see "IRS"

Example: create new defaults to no other
  Given I have a discharge other
  When I go to the discharge page
    And I give it a complex amount
  Then I should NOT see "credit discharge"

Example: create new success with other
  Given I have a discharge other
  When I go to the discharge page
    And I select credit discharge
    And I give it a complex amount
  Then I should see a notice

Example: create new with other permitted
  Given I have a discharge other
  When I go to the discharge page
    And I select credit discharge
    And I give it a complex amount
  Then I should see "credit discharge"

Example: create new failure
  When I go to the discharge page
    And I give it a zero amount
  Then I should see an error

Example: edit discharge title
  Given it has a small discharge
  When I go to edit the Visa discharge
  Then the title should be 'BtB: Edit Visa Discharge'

Example: edit discharge success
  Given it has a small discharge
  When I go to edit the Visa discharge
    And I give it a large amount
  Then I should see a notice

Example: edit discharge failure
  Given it has a small discharge
  When I go to edit the Visa discharge
    And I give it a zero amount
  Then I should see an error

Example: change discharge debt notice
  Given it has a small discharge
    And I have a itunes debt
  When I go to edit the Visa discharge
    And I select iTunes
    And I press Update
  Then I should see a notice

Example: change discharge debt success
  Given it has a small discharge
    And I have a itunes debt
  When I go to edit the Visa discharge
    And I select iTunes
    And I press Update
  Then I should see 'iTunes'

Example: delete discharge title
  Given it has a small discharge
  When I go to delete the Visa discharge
  Then the title should be 'BtB: Delete Visa Discharge'

Example: delete success
  Given it has a small discharge
  When I go to delete the Visa discharge
    And I confirm
  Then I should see an alert

Example: delete abort
  Given it has a small discharge
  When I go to delete the Visa discharge
    And I change my mind
  Then I should see a notice

Example: discharge amounts on debt page
  Given it has a small discharge
    And it has a large discharge
    When I go to the Visa page
  Then I should see "50c"
