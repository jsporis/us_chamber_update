SELECT

count(*) employers_eligible_for_search

FROM realign_hiring_our_heroes.user u
LEFT JOIN realign_hiring_our_heroes.employer e on u.id=e.user_id
INNER JOIN Reporting_chamber.chamber_users cu on u.uuid=cu.uuid
WHERE cu.employers=1
or cu.recruiter=1
or cu.employer_request=1
or cu.unapproved_employer=1



