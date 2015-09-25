### CS STATS -----
queryCSCompletion <- paste0(readLines('./sql/cs_resume_completion.sql', warn=FALSE), collapse=' ')
cs_resume_completion <- RJDBC::dbGetQuery(conn,queryCSCompletion)


queryCSSearchable <- paste0(readLines('./sql/cs_resume_searchable.sql', warn=FALSE), collapse=' ')
cs_resume_searchable <- RJDBC::dbGetQuery(conn,queryCSSearchable)

cs_resumes_totals <- sum(cs_resume_searchable$resumes)

cs_resume_stats <- data.frame(
                              cs_resumes=sum(cs_resume_searchable$resumes),
                              cs_resumes_searchable=cs_resume_searchable$resumes[cs_resume_searchable$cs_is_searchable==1],
                              percent_90_number=sum(cs_resume_completion$count[cs_resume_completion$completion>=90])
                              )

cs_resume_stats$percent_90 <- percent(cs_resume_stats$percent_90_number/cs_resume_stats$cs_resumes)
cs_resume_stats$percent_searchable <- percent(cs_resume_stats$cs_resumes_searchable/cs_resume_stats$cs_resumes)
