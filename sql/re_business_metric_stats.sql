SELECT

users.uuid, users.id,
metrics.downloads,
metrics.resume_email,
metrics.resume_preview,
searches.total_searches

FROM

(

SELECT

cu.uuid, u.id

FROM realign_hiring_our_heroes.user u
INNER JOIN Reporting_chamber.chamber_users cu on u.uuid=cu.uuid
WHERE cu.employers=1
or cu.recruiter=1
or cu.employer_request=1
or cu.unapproved_employer=1

) users

LEFT JOIN 

(
select 
	ml.person_id as user_id,
	sum((CASE WHEN ml.event_name like 'employerResumeDownload' then 1 else 0 end)) downloads,
	sum((CASE WHEN ml.event_name like 'employerResumeEmail' then 1 else 0 end)) resume_email,
	sum((CASE WHEN ml.event_name like 'employerResumePreview' then 1 else 0 end)) resume_preview

FROM
	realign_hiring_our_heroes.metric_log ml
WHERE 
	ml.event_name in ('employerResumeDownload','employerResumeEmail','employerResumePreview')
GROUP BY ml.person_id
) metrics

ON users.id=metrics.user_id

LEFT JOIN 

(

SELECT

user_id, count(*) total_searches

FROM realign_hiring_our_heroes.employer_search

GROUP BY user_id
) searches

on users.id=searches.user_id
