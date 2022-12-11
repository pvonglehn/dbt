with
    food_entries as (
        select
            full_date,
            time,
            timestamp(concat(full_date, ' ', time, ':00')) as timestamp,
            row_number() over (partition by full_date, time) as rk
        from `personal-consumption-tracker.consumption.nutrilio_gcs_native`
        where food is not null and full_date >= '2022-09-18'
    ),

    deduplicated_food_entries as (
        select full_date, time, timestamp from food_entries where rk = 1
    ),

    hours_since_last_meal as (
        select
            full_date,
            time,
            timestamp_diff(
                timestamp, lag(timestamp) over (order by timestamp asc), hour
            ) as hours
        from deduplicated_food_entries
        order by timestamp asc
    ),

    fasting_times as (
        select
            full_date,
            time,
            hours as hours_since_eating,
            rank() over (
                partition by full_date order by hours desc
            ) as rank_time_since_eating
        from hours_since_last_meal
        where time > '05:00'
        order by full_date desc, time desc
    )

select full_date, time as breakfast_time, hours_since_eating as fasting_time_hours
from fasting_times
where rank_time_since_eating = 1