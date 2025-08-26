Feature: manipulating a charge

Background:
  Given I have a Visa debt

Example: create new success without memo
  When I go to the charge page
    And I give it a small amount
  Then I should see a notice

Example: create new success with memo
  When I go to the charge page
    And I enter the memo SocSec
    And I give it a complex amount
  Then I should see a notice

Example: create new memo permitted
  When I go to the charge page
    And I enter the memo SocSec
    And I give it a complex amount
  Then I should see "SocSec"

Example: create new defaults to no recipient
  Given I have an charge recipient
  When I go to the charge page
    And I give it a complex amount
  Then I should NOT see "credit charge"

Example: create new success with recipient
  Given I have an charge recipient
  When I go to the charge page
    And I select credit charge
    And I give it a complex amount
  Then I should see a notice

Example: create new with recipient permitted
  Given I have an charge recipient
  When I go to the charge page
    And I select credit charge
    And I give it a complex amount
  Then I should see "credit charge"

Example: create new failure
  When I go to the charge page
    And I give it a zero amount
  Then I should see an error

Example: edit charge title
  Given it has a small charge
  When I go to edit the Visa charge
  Then the title should be 'IDNAB: Edit Visa Charge'

Example: edit charge success
  Given it has a small charge
  When I go to edit the Visa charge
    And I give it a large amount
  Then I should see a notice

Example: edit charge failure
  Given it has a small charge
  When I go to edit the Visa charge
    And I give it a zero amount
  Then I should see an error

Example: change charge debt notice
  Given it has a small charge
    And I have a itunes debt
  When I go to edit the Visa charge
    And I select iTunes
    And I press Update
  Then I should see a notice

Example: change charge debt success
  Given it has a small charge
    And I have a itunes debt
  When I go to edit the Visa charge
    And I select iTunes
    And I press Update
  Then I should see 'iTunes'

Example: delete charge title
  Given it has a small charge
  When I go to delete the Visa charge
  Then the title should be 'IDNAB: Delete Visa Charge'

Example: delete success
  Given it has a small charge
  When I go to delete the Visa charge
    And I confirm
  Then I should see an alert

Example: delete abort
  Given it has a small charge
  When I go to delete the Visa charge
    And I change my mind
  Then I should see a notice

Example: charge amounts on debt page
  Given it has a small charge
    And it has a large charge
    When I go to the Visa page
  Then I should see "50c"
