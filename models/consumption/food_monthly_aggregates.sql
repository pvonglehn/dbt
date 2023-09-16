select
    date_trunc(full_date, month) as month_start_date,
    count(*) / count(distinct full_date) as average_eating_events_per_day,
    countif(food_types like '%Pastry%') as number_of_pastries,
    countif(Health IN (1,2)) / count(distinct full_date) as average_unhealthy_snacks_per_day,
    countif(Health IN (1,2)) as unhealthy_snacks_per_week
from {{ ref("food") }}
where date_trunc(full_date, week) > '2022-07-01'
group by 1
order by 1 asc
