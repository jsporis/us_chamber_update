### ERM STATS -----
queryEventStats <- paste0(readLines('./sql/vjs_event_stats.sql', warn=FALSE), collapse=' ')
vjs_event_stats <- RJDBC::dbGetQuery(conn,queryEventStats)

vjs_event_stats[is.na(vjs_event_stats)] <- 0


queryVJSStats <- paste0(readLines('./sql/vjs_overall_stats.sql', warn=FALSE), collapse=' ')
vjs_overall_stats <- RJDBC::dbGetQuery(conn,queryVJSStats)



