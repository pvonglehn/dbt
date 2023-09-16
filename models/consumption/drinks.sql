SELECT Full_Date, Time,
trim(regexp_replace(drinks, '\\([0-9]×\\)', '')) AS drink_type
FROM  `personal-consumption-tracker.consumption.nutrilio_gcs_native`
where drinks is not null 
