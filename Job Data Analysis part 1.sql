create database project3;
use project3;

# talble -1 users

create table users(
user_id int,
created_at varchar(100),
company_id int,
`language` varchar(50),
activated_at varchar(100),
status varchar(50));

SHOW VARIABLES lIKE 'secure_file_priv';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


alter table users
add column temp_created_at datetime;

UPDATE users SET temp_created_at = STR_TO_DATE(created_at, '%d-%m-%Y %H:%i');

ALTER TABLE users DROP COLUMN created_at;

ALTER TABLE users CHANGE COLUMN temp_created_at created_at DATETIME;

select * from users;

#tab;e -2 events

create table `events`(
user_id int,
occurred_at varchar(100),
event_type varchar(50),
event_name varchar(50),
loaction varchar(50),
device varchar(50),
user_type int);

SHOW VARIABLES lIKE 'secure_file_priv';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/events.csv'
INTO TABLE `events`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

desc events;

alter table `events`
add column temp_occurred_at datetime;

UPDATE `events` SET temp_occurred_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

ALTER TABLE `events` DROP COLUMN occurred_at;

ALTER TABLE `events` CHANGE COLUMN temp_occurred_at occurred_at DATETIME;

select * from `events`;

#table -3 email_events

create table email_events(
user_id int,
occurred_at varchar(100),
actions varchar(100),
user_type int);

SHOW VARIABLES lIKE 'secure_file_priv';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/email_events.csv'
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

desc email_events;

alter table email_events
add column temp_occurred_at datetime;

UPDATE email_events SET temp_occurred_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

ALTER TABLE email_events DROP COLUMN occurred_at;

ALTER TABLE email_events CHANGE COLUMN temp_occurred_at occurred_at DATETIME;

select * from email_events;

# Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
# Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.

#table - 4 job_data

create table job_data(
ds varchar(100),
job_id int,
actor_id int,
`events` varchar(100),
`language` varchar(100),
 time_spent int,
 org varchar(10));

SHOW VARIABLES lIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/job_data.csv'
INTO TABLE job_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

desc job_data;

alter table job_data
add column temp_ds_at date;

UPDATE job_data SET temp_ds_at = STR_TO_DATE(ds, '%m-%d-%Y');

ALTER TABLE job_data DROP COLUMN ds;

ALTER TABLE job_data CHANGE COLUMN temp_ds_at ds DATETIME;

select * from job_data;

# Number of jobs reviewed: Amount of jobs reviewed over time.
# Your task: Calculate the number of jobs reviewed per hour per day for November 2020?

select count(distinct job_id)/(30*24) as num_jobs_reviewed from job_data
where ds between '2020-11-01' and '2020-11-30';

# Throughput: It is the no. of events happening per second.
# Your task: Let’s say the above metric is called throughput. Calculate 7 day rolling average of throughput? 
# For throughput, do you prefer daily metric or 7-day rolling and why?

select ds, jobs_reviewed,avg(jobs_reviewed) over(order by ds rows between 6 preceding and current row) as throughput_7 from
(select ds, count(distinct job_id) as jobs_reviewed
from job_data
where ds between '2020-11-01' and '2020-11-30'
group by ds
) as a;

# Percentage share of each language: Share of each language for different contents.
# Your task: Calculate the percentage share of each language in the last 30 days?

create view No_of_each_language_table as
select *, count(`language`) over(partition by `language`) as No_of_each_language from job_data
where ds between '2020-11-01' and '2020-11-30';

select 100 * No_of_each_language/count(`language`) over() from No_of_each_language_table;

#Duplicate rows: Rows that have the same value present in them.
#Your task: Let’s say you see some duplicate rows in the data.How will you display duplicates from the table?

select * from(
select *, row_number() over(partition by job_id order by job_id) as rownumber from job_data) as inner_query 
where rownumber > 1;


