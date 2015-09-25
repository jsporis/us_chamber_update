SELECT 

cs_is_searchable, count(*) resumes 

from Reporting_chamber.cs_mongo_user_ids cis
LEFT JOIN realign_career_spark.user csu on csu.id=cis.cs_user_id
INNER JOIN Reporting_chamber.chamber_users cu on csu.uuid=cu.uuid

group by cs_is_searchable
;