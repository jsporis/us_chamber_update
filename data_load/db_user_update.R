##USER UPDATE -----

queryRecentUsers <- 
  "
SELECT
	cu.id cd_user_id,
	cu.uuid, 
	REPLACE(REPLACE(cu.creation_source,'-first',''),'_nbc','') creation_source,
	login.last_login,
	(CASE WHEN cu.user_type ='' then NULL else cu.user_type end) user_type, 
  (CASE WHEN cu.enabled=1 then 1 else 0 end) enabled,
	(CASE WHEN created_at like '0000%' then NULL WHEN created_at like '1970-01-01%' then NULL else created_at END) as created_at,
	(CASE WHEN cu.roles LIKE '%ROLE_EMPLOYER%' then 1 else 0 end) as employers,
	(CASE WHEN cu.roles LIKE '%ROLE_JOB_SEEKER%' then 1 else 0 end) as job_seekers,
	(CASE WHEN cu.roles LIKE '%RECRUITER%' then 1 else 0 end) as recruiter,
	(CASE WHEN cu.roles LIKE '%REQUEST_EMPLOYER%' then 1 else 0 end) as employer_request,
	(CASE WHEN cu.roles LIKE '%UNAPPROVED%' then 1 else 0 end) as unapproved_employer,
	(CASE WHEN cu.roles LIKE '%ADMIN%' then 1 else 0 end) as admin,
	(CASE WHEN cu.roles LIKE '%a:0:{}%' then 1 else 0 end) as no_role_assigned
	


FROM

chamber_dashboard.user cu

LEFT JOIN (SELECT user_id, max(date_logged) last_login FROM chamber_dashboard.login_tracking group by user_id) login on cu.id=login.user_id

WHERE email not like '%iostudio%'
and email not like '%qatesto%'
and roles not like '%denied%'

and (date(login.last_login) >= date_sub(CURRENT_DATE, INTERVAL 2 DAY)
OR date(cu.created_at) >= date_sub(CURRENT_DATE, INTERVAL 2 DAY))
"

usersList <- dbGetQuery(conn,queryRecentUsers)

colnames(usersList)[1] <- 'cd_user_id'


userInsert <- paste0(
  'INSERT INTO Reporting_chamber.chamber_users (',
  paste0(colnames(usersList),collapse=','),') ','VALUES ',
  
  paste0(' (',
  '"',usersList[,1],'", ',
  '"',usersList[,2],'", ',
  '"',usersList[,3],'", ',
  '"',usersList[,4],'", ',
  '"',usersList[,5],'", ',
  '"',usersList[,6],'", ',
  '"',usersList[,7],'", ',
  '"',usersList[,8],'", ',
  '"',usersList[,9],'", ',
  '"',usersList[,10],'", ',
  '"',usersList[,11],'", ',
  '"',usersList[,12],'", ',
  '"',usersList[,13],'", ',
  '"',usersList[,14],'") ', collapse=','),
  ' ON DUPLICATE KEY UPDATE creation_source=values(creation_source), last_login=values(last_login), user_type=values(user_type), enabled=values(enabled), created_at=values(created_at), employers=values(employers), job_seekers=values(job_seekers), recruiter=values(recruiter), employer_request=values(employer_request), unapproved_employer=values(unapproved_employer)'
)

userInsert <- gsub("\"NA\"","NULL",userInsert)
dbSendUpdate(connUpdate,userInsert)


## CAREER SPARK MONGO UPDATE ------

tmpIds <- rmongodb::mongo.find.all(mongo, 'career_spark.resume', query='{ }',fields='{"userId":1, "_id":1}')
tmpSearchableTrue <- rmongodb::mongo.find.all(mongo, 'career_spark.resume', query='{"personalInfo.isSearchable":true }',fields='{"personalInfo.isSearchable":1, "userId":1 ,"_id":1}')

tmpIds <- rbindlist(tmpIds)
tmpSearchableTrue <- rbindlist(tmpSearchableTrue)

tmpSearchableTrue$personalInfo <- NULL
tmpSearchableTrue$cs_is_searchable <- 1

tmpIds <- merge(tmpIds, tmpSearchableTrue, by='_id', all.x=T)
tmpIds$cs_is_searchable[is.na(tmpIds$cs_is_searchable)] <- 0
tmpIds$`_id` <- NULL
tmpIds <- tmpIds %>% select(cs_user_id=userId.x, cs_is_searchable)
tmpIds <- data.frame(tmpIds)

csInsert <- paste0(
  'INSERT INTO Reporting_chamber.cs_mongo_user_ids (',paste0(colnames(tmpIds),collapse=','),') ','VALUES ',
  paste0("(",tmpIds[,1],",",tmpIds[,2],")", collapse=','),
  ' ON DUPLICATE KEY UPDATE cs_is_searchable=values(cs_is_searchable)'
)


dbSendUpdate(connUpdate,csInsert)


### CLEAN UP -----
dbDisconnect(connUpdate)
rm(usersList,connUpdate,tmpSearchableTrue,tmpIds)
