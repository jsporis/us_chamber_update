SELECT 

creation_source, date(created_at) date, count(*) sign_ups

FROM Reporting_chamber.chamber_users

WHERE date(created_at) >= date_sub(CURRENT_DATE, INTERVAL 30 day)

GROUP BY creation_source, date(created_at)

ORDER BY creation_source, date(created_at)


