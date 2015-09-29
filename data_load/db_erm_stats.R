### ERM STATS -----
queryERMarticleStats <- paste0(readLines('./sql/erm_article_stats.sql', warn=FALSE), collapse=' ')
erm_article_stats <- RJDBC::dbGetQuery(conn,queryERMarticleStats)

queryERMarticleComments <- paste0(readLines('./sql/erm_article_comments.sql', warn=FALSE), collapse=' ')
erm_article_comments <- RJDBC::dbGetQuery(conn,queryERMarticleComments)



### SUMMARIZE

erm_summary <- erm_article_stats %>% 
  summarize(
    articles_read=length(object_nid), 
    total_number_of_reads=sum(read_count), 
    avg_reads_per_article=round(total_number_of_reads/articles_read,1),
    feedback_is_helpful=sum(is_helpful_yes),
    feedback_is_not_helpful=sum(is_helpful_no),
    feedback_percent_positive=percent(feedback_is_helpful/(feedback_is_not_helpful+feedback_is_helpful)),
    feedback_percent_negative=percent(feedback_is_not_helpful/(feedback_is_not_helpful+feedback_is_helpful))
    )

erm_summary <- cbind(erm_summary,shares=ermShares, prints=ermPrint)


## FINAL TWEAKS FOR DISPLAY

erm_article_stats$object_nid <- NULL
colnames(erm_article_stats) <- toupper(colnames(erm_article_stats))


erm_summary$name <- 'name'
erm_summary <- melt(erm_summary, id='name')
erm_summary$name <- NULL
colnames(erm_summary) <- toupper(colnames(erm_summary))
erm_summary$VARIABLE <- toupper(erm_summary$VARIABLE)

colnames(erm_article_comments) <- toupper(colnames(erm_article_comments))
