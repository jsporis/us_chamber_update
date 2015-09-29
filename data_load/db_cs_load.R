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

cs_resume_stats$cs_resumes <- format(cs_resume_stats$cs_resumes, big.mark=',')
cs_resume_stats$cs_resumes_searchable <- format(cs_resume_stats$cs_resumes_searchable, big.mark=',')
cs_resume_stats$percent_90_number <- format(cs_resume_stats$percent_90_number, big.mark=',')
cs_resume_stats$name <- 'name'
cs_resume_stats <- melt(cs_resume_stats, id='name')
cs_resume_stats$name <- NULL
cs_resume_stats$variable <- toupper(cs_resume_stats$variable)
colnames(cs_resume_stats) <- toupper(colnames(cs_resume_stats))

## COMPLETION CHART
chartCScomplete <- ggplot(data=cs_resume_completion, aes(x=factor(completion), y=count)) + 
                      geom_bar(stat='identity', fill='#E0F0E9') + 
                      geom_text(aes(label = count),  position=position_dodge(width=0.7), vjust = -1, size = 4, color = "#1A2D2E") +
                      scale_y_continuous(limit=c(0,max(cs_resume_completion$count)*1.1)) +
                      chartTheme