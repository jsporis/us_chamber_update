### ERM STATS -----
queryEventStats <- paste0(readLines('./sql/vjs_event_stats.sql', warn=FALSE), collapse=' ')
vjs_event_stats <- RJDBC::dbGetQuery(conn,queryEventStats)

vjs_event_stats[is.na(vjs_event_stats)] <- 0


queryVJSStats <- paste0(readLines('./sql/vjs_overall_stats.sql', warn=FALSE), collapse=' ')
vjs_overall_stats <- RJDBC::dbGetQuery(conn,queryVJSStats)



vjs_overall_stats <- melt(vjs_overall_stats)
vjs_overall_stats$value <- format(vjs_overall_stats$value, big.mark=',')
vjs_overall_stats$value <- gsub('.00','', vjs_overall_stats$value)
colnames(vjs_overall_stats) <- toupper(colnames(vjs_overall_stats))

colnames(vjs_event_stats) <- toupper(colnames(vjs_event_stats))

queryEventParticipant <- paste0(readLines('./sql/vjs_event_participants.sql', warn=FALSE), collapse=' ')
vjs_event_participants <- RJDBC::dbGetQuery(conn,queryEventParticipant)
