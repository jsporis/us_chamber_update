SELECT
ml.event_name, COUNT(*) count
FROM realign_hiring_our_heroes.metric_log ml  
LEFT JOIN realign_hiring_our_heroes.user hu on ml.person_id=hu.id 
INNER JOIN Reporting_chamber.chamber_users cu on cu.uuid=hu.uuid
GROUP BY ml.event_name;