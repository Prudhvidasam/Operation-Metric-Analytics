# Percentage share of each language: Share of each language for different contents.
# Your task: Calculate the percentage share of each language in the last 30 days?

create view No_of_each_language_table as
select *, count(`language`) over(partition by `language`) as No_of_each_language from job_data
where ds between '2020-11-01' and '2020-11-30';

select 100 * No_of_each_language/count(`language`) over() from No_of_each_language_table;