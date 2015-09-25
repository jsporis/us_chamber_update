select 
	emp.employer_id,
	emp.zip_code,
	emp.user_id,
	user.email,
	emp.business_name,
	emp.phone,
	emp.street,
	emp.city,
	emp.state

FROM
	realign_hiring_our_heroes.employer emp
JOIN 
	realign_hiring_our_heroes.user on user.id = emp.user_id
INNER JOIN
	Reporting_chamber.chamber_users cu on user.uuid=cu.uuid
