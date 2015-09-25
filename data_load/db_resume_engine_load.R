#### RE STATS ------

queryREcompletion <- paste0(readLines('./sql/re_resume_completion.sql', warn=FALSE), collapse=' ')
re_resume_completion <- RJDBC::dbGetQuery(conn,queryREcompletion)


queryREresume <- paste0(readLines('./sql/re_resume_count.sql', warn=FALSE), collapse=' ')

re_resume_stats <- RJDBC::dbGetQuery(conn,queryREresume)


re_resume_stats$percent_90_number <- sum(re_resume_completion$re_resumes[re_resume_completion$percent_complete>=90])
re_resume_stats$percent_90 <- percent(re_resume_stats$percent_90_number/re_resume_stats$re_resumes)
re_resume_stats$percent_searchable <- percent(re_resume_stats$re_resumes_searchable/re_resume_stats$re_resumes)




### BUSINESS STATS

queryREcompanies <- paste0(readLines('./sql/re_companies.sql', warn=FALSE), collapse=' ')
re_companies <- RJDBC::dbGetQuery(conn,queryREcompanies)

queryREBizStats <- paste0(readLines('./sql/re_business_metric_stats.sql', warn=FALSE), collapse=' ')
re_biz_stats <- RJDBC::dbGetQuery(conn,queryREBizStats)
re_biz_stats[is.na(re_biz_stats)] <- 0

queryREbusinessList <- paste0(readLines('./sql/re_business_list.sql', warn=FALSE), collapse=' ')
re_business_list <- RJDBC::dbGetQuery(conn,queryREbusinessList)


re_statistic_all_business <- melt(re_biz_stats[,c('downloads','resume_email','resume_preview','total_searches')]) %>% 
                              group_by(variable) %>% 
                              summarize(
                                        user_count=length(value),
                                        mean=mean(value),
                                        mediam=median(value),
                                        min=min(value),
                                        max=max(value),
                                        mode=names(table(value))[table(value) == max(table(value))]
                                        )


re_statistic_active_business <- melt(re_biz_stats[,c('downloads','resume_email','resume_preview','total_searches')]) %>% 
                              group_by(variable) %>% 
                              summarize(
                                        user_count=length(value[value>0]),
                                        mean=mean(value[value>0]),
                                        mediam=median(value[value>0]),
                                        min=min(value[value>0]),
                                        max=max(value[value>0]),
                                        mode=names(table(value[value>0]))[table(value[value>0]) == max(table(value[value>0]))]
                                        )


re_biz_stats_summary <- re_biz_stats %>% 
                              summarize(
                                        employers_eligible_for_search=length(uuid),
                                        employer_companies=re_companies$companies,
                                        resume_searches=sum(total_searches),
                                        resume_previews=sum(resume_preview),
                                        resume_downloads=sum(downloads),
                                        resume_emails=sum(resume_email)  
                                        )

rm(re_biz_stats, re_companies)
