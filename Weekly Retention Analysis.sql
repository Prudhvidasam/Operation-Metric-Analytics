#Weekly Retention Analysis:
#Objective: Analyze the retention of users on a weekly basis after signing up for a product.
#Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.

select * from `events`;

select distinct user_id, count(user_id), sum(case when retention_week = 1 then 1 else 0 end) as per_week_retention 
from
(
select a.user_id, a.signup_week, b.Engagement_week, b.Engagement_week-a.signup_week as retention_week
from
(
select distinct user_id, week(occurred_at) as signup_week
from `events`
where event_type = 'signup_flow' and event_name = 'complete_signup'
) a
left join
(
select distinct user_id, week(occurred_at) as Engagement_week
from `events`
where event_type = 'engagement'
) b
on a.user_id = b.user_id
)c
group by user_id;