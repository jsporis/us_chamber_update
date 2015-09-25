SELECT


count(*) re_resumes,
sum((case when is_searchable = 1 then 1 else 0 end)) re_resumes_searchable


FROM realign_hiring_our_heroes.person_resume pr
LEFT JOIN realign_hiring_our_heroes.person_searchable ps on ps.person_id=pr.person_id
LEFT JOIN realign_hiring_our_heroes.user hu on hu.id=pr.person_id
INNER JOIN Reporting_chamber.chamber_users cu on hu.uuid=cu.uuid