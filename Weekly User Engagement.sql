#Weekly User Engagement:
#Objective: Measure the activeness of users on a weekly basis.
#Your Task: Write an SQL query to calculate the weekly user engagement.

SELECT week(occurred_at) as week_of_the_year, COUNT(DISTINCT e.user_id) AS weekly_active_users
FROM `events` as e
group by week_of_the_year;