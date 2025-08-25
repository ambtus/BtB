Feature: manipulating a recipient

Example: recipient name on home page
  Given I have an income recipient
  When I am on the home page
  Then I should see "cash income"

Example: show recipient title
  Given I have an income recipient
  When I am on the home page
    And I follow cash income
  Then the title should be 'IDNAB: cash income Recipient'

Example: create new success
  When I am on the home page
    And I follow New Income Recipient
  And I give it the name xyzzy
  Then I should see a notice

Example: create new failure
  Given I have an income recipient
  When I am on the home page
    And I follow New Income Recipient
  And I name it cash income
  Then I should see an alert
    And I should see an error

Example: edit recipient title
  Given I have an income recipient
  When I am on the home page
    And I follow cash income
    And I follow Edit
  Then the title should be 'IDNAB: Edit cash income Recipient'

Example: edit recipient success
  Given I have an income recipient
  When I am on the home page
    And I follow cash income
    And I follow Edit
  And I name it xyzzy
  Then I should see a notice

Example: edit recipient failure
  Given I have an income recipient
    And I have a outgo recipient
  When I am on the home page
    And I follow cash income
    And I follow Edit
  And I name it cash outgo
  Then I should see an alert
    And I should see an error

Example: delete title
  Given I have an income recipient
  When I am on the home page
    And I follow cash income
    And I follow Delete
  Then the title should be 'IDNAB: Delete cash income Recipient'

Example: delete success
  Given I have an income recipient
  When I am on the home page
    And I follow cash income
    And I follow Delete
    And I confirm
  Then I should see an alert

Example: delete abort
  Given I have an income recipient
  When I am on the home page
    And I follow cash income
    And I follow Delete
    And I change my mind
  Then I should see a notice


