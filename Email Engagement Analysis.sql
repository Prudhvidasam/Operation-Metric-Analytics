#Email Engagement Analysis:
#Objective: Analyze how users are engaging with the email service.
#Your Task: Write an SQL query to calculate the email engagement metrics.

select * from email_events;

select
email_engagement_week,
no_of_users,
weekly_digest_sent,
weekly_digest_sent-lag(weekly_digest_sent) over(order by email_engagement_week) as weekly_digest_sent_growth,
email_open,
email_open-lag(email_open) over(order by email_engagement_week) as email_open_growth,
email_clickthrough,
email_clickthrough-lag(email_clickthrough) over(order by email_engagement_week) as email_clickthrough_growth
from
(select week(occurred_at) as email_engagement_week,
count(distinct user_id) as no_of_users, 
sum(if(actions='sent_weekly_digest',1,0)) as weekly_digest_sent,
sum(if(actions='email_open',1,0)) as email_open,
sum(if(actions='email_clickthrough',1,0)) as email_clickthrough
 from email_events
 group by email_engagement_week
 order by email_engagement_week) a;