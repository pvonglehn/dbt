select
    full_date,
    countif(drink_type like '%Coffee%') as number_of_coffees
from {{ ref("drinks") }}
where date_trunc(full_date, week) > '2022-07-01'
group by 1
order by 1 asc
