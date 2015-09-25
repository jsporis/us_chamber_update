SELECT

percent_complete,
count(*) re_resumes


FROM realign_hiring_our_heroes.person_completion pc
LEFT JOIN realign_hiring_our_heroes.user hu on hu.id=pc.person_id
INNER JOIN Reporting_chamber.chamber_users u on u.uuid=hu.uuid

GROUP BY percent_complete ORDER BY percent_complete ASC
	