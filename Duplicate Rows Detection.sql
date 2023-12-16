#Duplicate rows: Rows that have the same value present in them.
#Your task: Let’s say you see some duplicate rows in the data.How will you display duplicates from the table?

select * from(
select *, row_number() over(partition by job_id order by job_id) as rownumber from job_data) as inner_query 
where rownumber > 1;