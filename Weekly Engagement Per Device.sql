#Weekly Engagement Per Device:
#Objective: Measure the activeness of users on a weekly basis per device.
#Your Task: Write an SQL query to calculate the weekly engagement per device.

select * from `events`;

select count(distinct user_id), device, week(occurred_at) as engagement_week, year(occurred_at) as engagement_year from `events`
where event_type = 'engagement'
group by device,engagement_week,engagement_year
order by device,engagement_week,engagement_year;