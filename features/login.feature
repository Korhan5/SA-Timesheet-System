# features/login.feature

Feature: Register
  As a registered member
  So that can see information about movies that interest me
  I want to login to the RottenPotatoes application

Background: profiles in database

  Given the following profiles exists:
  | privilege|org|org2|manager_id|grad|user_id|
  | 0        | 0 | 1  |420       |0   |       |
  
@omniauth_test1
Scenario: login
  Given I am on the landing page
  And I press "Register or Login with GitHub"
  Then I will see "Welcome Tester Suny! You have signed up via github."  
  #And I will see the SA-Timesheet Dashboard
  And I will see "Editing profile" 