select
    full_date,
    count(*) as eating_events,
    countif(food_types like '%Pastry%') as number_of_pastries,
    countif(Health IN (1,2)) as unhealthy_snacks
from {{ ref("food") }}
where date_trunc(full_date, week) > '2022-07-01'
group by 1
order by 1 asc