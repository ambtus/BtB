Feature: manipulating an outgo

Background:
  Given I have a checking asset
    * it has a compound income

Example: create new success without memo
  When I go to the outgo page
    And I give it a small amount
  Then I should see a notice

Example: create new success with memo
  When I go to the outgo page
    And I enter the memo IRS
    And I give it a complex amount
  Then I should see a notice

Example: create new memo permitted
  When I go to the outgo page
    And I enter the memo IRS
    And I give it a complex amount
  Then I should see "IRS"

Example: create new defaults to no recipient
  Given I have a outgo recipient
  When I go to the outgo page
    And I give it a complex amount
  Then I should NOT see "cash outgo"

Example: create new success with recipient
  Given I have a outgo recipient
  When I go to the outgo page
    And I select cash outgo
    And I give it a complex amount
  Then I should see a notice

Example: create new with recipient permitted
  Given I have a outgo recipient
  When I go to the outgo page
    And I select cash outgo
    And I give it a complex amount
  Then I should see "cash outgo"

Example: create new failure
  When I go to the outgo page
    And I give it a zero amount
  Then I should see an error

Example: edit outgo title
  Given it has a small outgo
  When I go to edit the checking outgo
  Then the title should be 'IDNAB: Edit Checking Outgo'

Example: edit outgo success
  Given it has a small outgo
  When I go to edit the checking outgo
    And I give it a large amount
  Then I should see a notice

Example: edit outgo failure
  Given it has a small outgo
  When I go to edit the checking outgo
    And I give it a zero amount
  Then I should see an error

Example: change outgo account notice
  Given it has a small outgo
    And I have a savings asset
  When I go to edit the checking outgo
    And I select Savings
    And I press Update
  Then I should see a notice

Example: change outgo account success
  Given it has a small outgo
    And I have a savings asset
  When I go to edit the checking outgo
    And I select Savings
    And I press Update
  Then I should see 'from Savings'

Example: delete outgo title
  Given it has a small outgo
  When I go to delete the checking outgo
  Then the title should be 'IDNAB: Delete Checking Outgo'

Example: delete success
  Given it has a small outgo
  When I go to delete the checking outgo
    And I confirm
  Then I should see an alert

Example: delete abort
  Given it has a small outgo
  When I go to delete the checking outgo
    And I change my mind
  Then I should see a notice

Example: outgo amounts on asset page
  Given it has a small outgo
    And it has a large outgo
    When I go to the checking page
  Then I should see "50c"
