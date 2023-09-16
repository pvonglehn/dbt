WITH daily AS (
select
    date_trunc(date_time, day) as dday
  , 'daily' AS aggregation
  , COUNT(*) AS drinks
from {{ ref("alcohol") }}
where date_trunc(date_time, week) > '2022-07-01'
group by 1
order by 1 asc)

, weekly AS (
select
    date_trunc(date_time, week) as dday
  , 'weekly' AS aggregation
  , COUNT(*) AS drinks
from {{ ref("alcohol") }}
where date_trunc(date_time, week) > '2022-07-01'
group by 1
order by 1 asc    
)

SELECT *
FROM daily
UNION ALL 
SELECT *
FROM weekly

