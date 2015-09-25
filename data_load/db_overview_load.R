### ACCOUNT SUMMARIES

queryAccountsByDate <- paste0(readLines('./sql/accounts_by_date_source.sql', warn=FALSE), collapse=' ')
queryAccountsByRole <- paste0(readLines('./sql/accounts_role_analysis.sql', warn=FALSE), collapse=' ')
queryAccountsProfiles <- paste0(readLines('./sql/accounts_profiles.sql', warn=FALSE), collapse=' ')

accountsByDate <- RJDBC::dbGetQuery(conn,queryAccountsByDate)
accountsByRole <- RJDBC::dbGetQuery(conn,queryAccountsByRole)
accountsProfiles <- RJDBC::dbGetQuery(conn,queryAccountsProfiles)

signupDaily <- ggplot(data=accountsByDate, aes(x=date, y=sign_ups, group=creation_source, color=creation_source)) + geom_line()

