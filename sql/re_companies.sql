SELECT 

count(*) companies

FROM realign_hiring_our_heroes.employer e
LEFT JOIN realign_hiring_our_heroes.user u on e.user_id=u.id
INNER JOIN Reporting_chamber.chamber_users cu on u.uuid=cu.uuid
