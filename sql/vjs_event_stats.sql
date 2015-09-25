SELECT

e.name as EVENT,
date(start_date) as START,
date(end_date) as END,
exhibitors,
sponsors,
REGISTERED,
`JOB SEEKERS`,
EMPLOYERS,
RECRUITER,
`EMPLOYER REQUESTS`,
employer_connections,
seeker_inquiry




FROM


		realign_vjs.events e

LEFT JOIN

(
		SELECT 

		event_id,
		count(cu.uuid) REGISTERED,
		sum(employers)+sum(unapproved_employer) EMPLOYERS,
		sum(job_seekers) 'JOB SEEKERS',
		sum(recruiter) RECRUITER,
		SUM(employer_request) 'EMPLOYER REQUESTS'
		 
		FROM
		realign_vjs.event_attendees ea 
		left join realign_vjs.user u on ea.attendee_id=u.profile_id
		INNER JOIN Reporting_chamber.chamber_users cu on u.uuid=cu.uuid
		GROUP BY ea.event_id

) b

on e.id=b.event_id

LEFT JOIN
(
		SELECT

		event_id,
		sum((CASE when message like '%joined%' then 1 else 0 end)) joined,
		sum((CASE when message like '%employer connect%' then 1 else 0 end)) employer_connections,
		sum((CASE when message like '%Seeker inqu%' then 1 else 0 end)) seeker_inquiry


		FROM realign_vjs.event_activity_logs el
		LEFT JOIN realign_vjs.user vu on el.user_id=vu.id
		INNER JOIN Reporting_chamber.chamber_users cu on vu.uuid=cu.uuid

		group by event_id

) a on e.id=a.event_id

LEFT JOIN
(
		SELECT 
		event_id, count(distinct company_id) exhibitors
		FROM realign_vjs.events_to_exhibitors_ref x
		LEFT JOIN realign_vjs.company_profile cp on x.company_id=cp.id
		LEFT JOIN realign_vjs.user vu on cp.user_id=vu.id
		INNER JOIN Reporting_chamber.chamber_users cu on vu.uuid=cu.uuid 
		group by event_id
) ex on e.id=ex.event_id

LEFT JOIN
(
		SELECT 
		event_id, count(distinct company_id) sponsors
		FROM realign_vjs.events_to_sponsors_ref x
		LEFT JOIN realign_vjs.company_profile cp on x.company_id=cp.id
		LEFT JOIN realign_vjs.user vu on cp.user_id=vu.id
		INNER JOIN Reporting_chamber.chamber_users cu on vu.uuid=cu.uuid 
		group by event_id
) s on e.id=s.event_id

ORDER BY START desc