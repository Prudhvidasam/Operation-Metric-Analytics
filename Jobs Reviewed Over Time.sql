# Number of jobs reviewed: Amount of jobs reviewed over time.
# Your task: Calculate the number of jobs reviewed per hour per day for November 2020?

select count(distinct job_id)/(30*24) as num_jobs_reviewed from job_data
where ds between '2020-11-01' and '2020-11-30';