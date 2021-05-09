Feature: Clock_out button
	As an employee
	I want SA employees to be able to clock out
  So that I can have the correct amount of hours worked

Background: timetable seeds
  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester Suny | stester@binghamton.edu |


  Given the following timetables exist:
  | time_in              | time_out             | notes       |
  | 2021-04-20 05:20:48  |                      | big job      |
  | 2019-04-20 05:20:48  | 2019-04-20 05:50:48  | fundraiser|  
  | 2021-01-25 05:40:58  | 2021-01-25 08:40:58  | meeting   |   
  | 2021-02-20 05:10:48  | 2021-02-28 05:10:48  | test       |  
  
	#Given I am logged into timesheets
@omniauth_test5
Scenario: clocks out on dashboard
	#Given I am logged into timesheets
  When I go to the timetable page
  And  I follow "Clock Out"
	Then I should be on the edit timetable page
  
Scenario: clocks out on show page
  Given I am on the show timetable page
  And  I follow "Clock Out"
	Then I should be on the edit timetable page
	


    
	
	