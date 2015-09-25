SELECT

completion, count(*) count

FROM

(
		SELECT

		uuid, coalesce(completion) completion

		FROM

		(
				SELECT 
				pc.*, csu.uuid
				FROM 
				realign_career_spark.percent_complete pc
				LEFT JOIN realign_career_spark.user csu on pc.user_id=csu.id
				INNER JOIN Reporting_chamber.chamber_users cu on cu.uuid=csu.uuid
				ORDER BY pc.user_id, pc.time desc
		)z

		GROUP BY z.user_id

) COMPLETE

GROUP BY completion

ORDER BY completion ASC 

