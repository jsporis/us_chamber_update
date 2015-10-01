SELECT 
e.start_date as event_start_date,
e.name as event_name,

u.username,
u.email,

cu.employers,
cu.job_seekers,
cu.recruiter,
cu.employer_request,
cu.unapproved_employer,
cu.admin,
cu.no_role_assigned

FROM
    realign_vjs.event_attendees ea

LEFT JOIN
    realign_vjs.user u on ea.attendee_id=u.profile_id

INNER JOIN
    Reporting_chamber.chamber_users cu on u.uuid=cu.uuid

LEFT JOIN
	realign_vjs.events e on ea.event_id=e.id

WHERE date(e.end_date) >= CURRENT_DATE 

order by event_start_date, event_name ASC

;