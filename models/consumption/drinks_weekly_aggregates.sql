select
    date_trunc(full_date, week) as week_start_date,
    countif(drink_type like '%Coffee%')/COUNT(DISTINCT full_date) as avg_number_of_coffees_per_day
from {{ ref("drinks") }}
where date_trunc(full_date, week) > '2022-07-01'
group by 1
order by 1 asc
