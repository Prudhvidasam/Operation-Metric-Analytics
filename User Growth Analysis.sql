#User Growth Analysis:
#Objective: Analyze the growth of users over time for a product.
#Your Task: Write an SQL query to calculate the user growth for the product.
select * from users;

select *,
num_active_users-lag(num_active_users) over( order by year_num,week_num) as user_growth
from
(
select extract(year from activated_at) as year_num, extract(week from activated_at) as week_num, 
count(distinct user_id) as num_active_users from  users
group by year_num,week_num
order by year_num,week_num
)a;