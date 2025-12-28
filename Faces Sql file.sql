
/*drop table if exists faces_dataset; 

CREATE TABLE Faces_dataset (
user_type varchar(200) ,
Signup_Date	 date    ,
Last_Login date  ,
Total_Logins	int ,
Session_Duration_Min decimal(8,2) ,
Location_Country	text ,
Location_City	text, 
Services_Used	 text  ,
Products_Viewed	int, 
Products_Purchased	int, 
Subscription_Status  varchar(4) ,
User_Id bigint 
);*/


--select * from faces_temp;

--select * , date(substr( signup_date ,7)||'-'|| substr(signup_date ,4,2)||'-'||substr( signup_date ,1,2) ) signup_date_updte 
--,date(substr( last_login,7)||'-'|| substr( last_login,4,2)||'-'||substr( last_login,1,2) ) Last_login_updte
--from faces_dataset ; 

--select max(last_login ) from Faces_dataset ;

Update faces_dataset 
set Location_Country = 'Canada' where Location_City = 'Toronto'  ;


Update faces_dataset 
set Location_Country = 'UK' where Location_City = 'London'  ;


Update faces_dataset 
set Location_Country = 'UK' where Location_City = 'Manchester'  ;

Update faces_dataset 
set Location_Country = 'Germany' where Location_City = 'Berlin'  ;

Update faces_dataset 
set Location_Country = 'Germany' where Location_City = 'Munich'  ;



Update faces_dataset 
set Location_Country = 'USA' where Location_City in ('New York','Los Angeles')
  ;


Update faces_dataset 
set Location_Country = 'Australia' where Location_City in ('Melbourne','Sydney')
  ;

--  Converting Signup_Date and Login_Date to Date_Format 
Drop table faces_temp;
CREATE TEMP TABLE faces_temp AS
select * , date(substr( signup_date ,7)||'-'|| substr(signup_date ,4,2)||'-'||substr( signup_date ,1,2) ) signup_date_updte 
,date(substr( last_login,7)||'-'|| substr( last_login,4,2)||'-'||substr( last_login,1,2) ) Last_login_updte
from faces_dataset ; 

--select max(signup_date_updte ) , max( Last_login_updte)from  faces_temp ;


--	Calculate active users (users who have logged in at least once in the past 30 days).
Drop  table Min_Max_login_dte_temp ;

CREATE TEMP TABLE  Min_Max_login_dte_temp AS
select   DATE( Max_login_dte, '-30 day') Min_30day_login_dte ,Max_login_dte from
(
select max(Last_login_updte) Max_login_dte from faces_temp ) a;



select count(distinct User_Id) Active_Users
from faces_temp  where Last_login_updte  >= ( select Min_30day_login_dte from  Min_Max_login_dte_temp )   
                      and    Last_login_updte  <= (select Max_login_dte from  Min_Max_login_dte_temp);




/*select user_id 
from faces_temp  where Last_login_updte  >= ( select Min_30day_login_dte from  Min_Max_login_dte_temp )   
                      and    Last_login_updte  <=(select Max_login_dte from  Min_Max_login_dte_temp);

*/

-- Most popular services User ar booking

select Services_used, count(*)
from faces_temp
group by 1 order by 2 desc;

--average time spent by User Category
select User_Type, round(avg(Session_Duration_Min),0)
user_type from faces_temp 
where user_type in ('Beautician' ,'Medical Prescriber' )
group by 1 order by 2 desc ;


-- Identify top regions or countries where Faces is most used.
SELECT Location_country , count(Distinct user_id)
from faces_temp 
group by 1  order by 2 desc ;


-- Create a percentage breakdown of users by location
SELECT Location_city ,   round(  cast( count(user_id)  as float) /  (select count(*) from faces_dataset)  ,3)*100 Location_City
from faces_temp 
group by 1  order by 2 desc ;

-- select * from faces_temp
-- Repeat users who have logged in more than 3 times a month
  -- select count(distinct user_id ) from faces_temp
select  round(  cast( count(user_id)  as float) /  (select count(distinct user_id ) from faces_temp )  ,3)*100 Repeat_Users
from faces_temp 
where Last_login_updte >= '2025-03-01' and total_logins >3 ;

-- select count(user_id )  from faces_temp where Last_login_updte >= '2025-03-01' and total_logins >3;


-- Drop of Rates -- Users have Signed up but never Purchased faces app
select round(  cast( Users_Never_used_Faces  as float) /  (select count(distinct user_id ) from faces_temp)  ,2)*100 Repeat_Users
from (
select    count(distinct user_id)  Users_Never_used_Faces 
from faces_temp where Products_Purchased =0 ) b ;

