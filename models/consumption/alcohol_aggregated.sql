WITH daily AS (
  SELECT
    date_trunc(date_time, day) AS dday,
    'daily' AS aggregation,
    COUNT(*) AS drinks
  FROM {{ ref("alcohol") }}
  WHERE date_trunc(date_time, week) > '2022-07-01'
  GROUP BY 1
)

, date_range AS (
  SELECT
    DATE_ADD(DATE '2022-07-01', INTERVAL seq.day DAY) AS dday
  FROM (
    SELECT
      ROW_NUMBER() OVER() AS day
    FROM
      UNNEST(GENERATE_ARRAY(0, DATE_DIFF(CURRENT_DATE(), DATE '2022-07-01', DAY))) AS seq
  ) AS seq
)

, daily_all_days AS (SELECT
  d.dday,
  'daily' AS aggregation,
  IFNULL(drinks, 0) AS drinks
FROM
  date_range AS d
LEFT JOIN
  daily AS a
ON
  d.dday = DATE(a.dday)  -- Cast a.dday to DATE
ORDER BY
  dday ASC)

, weekly AS (
select
    date_trunc(dday, week) as dday
  , 'weekly' AS aggregation
  , SUM(drinks) AS drinks
from daily_all_days
where date_trunc(dday, week) > '2022-07-01'
group by 1
order by 1 asc    
)

SELECT *
FROM daily_all_days
UNION ALL 
SELECT *
FROM weekly

