# Throughput: It is the no. of events happening per second.
# Your task: Let’s say the above metric is called throughput. Calculate 7 day rolling average of throughput? 
# For throughput, do you prefer daily metric or 7-day rolling and why?

select ds, jobs_reviewed,avg(jobs_reviewed) over(order by ds rows between 6 preceding and current row) as throughput_7 from
(select ds, count(distinct job_id) as jobs_reviewed
from job_data
where ds between '2020-11-01' and '2020-11-30'
group by ds
) as a;