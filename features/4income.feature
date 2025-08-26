Feature: manipulating an income

Background:
  Given I have a checking asset

Example: create new success without memo
  When I go to the income page
    And I give it a small amount
  Then I should see a notice

Example: create new success with memo
  When I go to the income page
    And I enter the memo SocSec
    And I give it a complex amount
  Then I should see a notice

Example: create new memo permitted
  When I go to the income page
    And I enter the memo SocSec
    And I give it a complex amount
  Then I should see "SocSec"

Example: create new defaults to no recipient
  Given I have an income recipient
  When I go to the income page
    And I give it a complex amount
  Then I should NOT see "cash income"

Example: create new success with recipient
  Given I have an income recipient
  When I go to the income page
    And I select cash income
    And I give it a complex amount
  Then I should see a notice

Example: create new with recipient permitted
  Given I have an income recipient
  When I go to the income page
    And I select cash income
    And I give it a complex amount
  Then I should see "cash income"

Example: create new failure
  When I go to the income page
    And I give it a zero amount
  Then I should see an error

Example: edit income title
  Given it has a small income
  When I go to edit the checking income
  Then the title should be 'IDNAB: Edit Checking Income'

Example: edit income success
  Given it has a small income
  When I go to edit the checking income
    And I give it a large amount
  Then I should see a notice

Example: edit income failure
  Given it has a small income
  When I go to edit the checking income
    And I give it a zero amount
  Then I should see an error

Example: change income account notice
  Given it has a small income
    And I have a savings asset
  When I go to edit the checking income
    And I select Savings
    And I press Update
  Then I should see a notice

Example: change income account success
  Given it has a small income
    And I have a savings asset
  When I go to edit the checking income
    And I select Savings
    And I press Update
  Then I should see 'Savings'

Example: delete income title
  Given it has a small income
  When I go to delete the checking income
  Then the title should be 'IDNAB: Delete Checking Income'

Example: delete success
  Given it has a small income
  When I go to delete the checking income
    And I confirm
  Then I should see an alert

Example: delete abort
  Given it has a small income
  When I go to delete the checking income
    And I change my mind
  Then I should see a notice

Example: income amounts on asset page
  Given it has a small income
    And it has a large income
    When I go to the checking page
  Then I should see "50c"
