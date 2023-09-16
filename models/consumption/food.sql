SELECT Full_Date, Time, Amount, Amount_text, Health, Health_text, 
trim(regexp_replace(food, '\\([0-9]×\\)', '')) AS food_types,
trim(regexp_replace(Exercises, '\\([0-9]×\\)', '')) AS chef
FROM  `personal-consumption-tracker.consumption.nutrilio_gcs_native`
where food is not null 
and full_date > '2022-09-01'