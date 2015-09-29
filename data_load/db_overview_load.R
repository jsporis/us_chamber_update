### ACCOUNT SUMMARIES

queryAccountsByDate <- paste0(readLines('./sql/accounts_by_date_source.sql', warn=FALSE), collapse=' ')
queryAccountsByRole <- paste0(readLines('./sql/accounts_role_analysis.sql', warn=FALSE), collapse=' ')
queryAccountsProfiles <- paste0(readLines('./sql/accounts_profiles.sql', warn=FALSE), collapse=' ')

accountsByDate <- RJDBC::dbGetQuery(conn,queryAccountsByDate)



signupDaily <- ggplot(data=accountsByDate, aes(x=as.Date(date), y=sign_ups, group=creation_source, color=creation_source)) + 
                geom_line(size=1.1) + chartTheme + scale_x_date(labels = date_format("%m/%d"), breaks=date_breaks("day"))


## ACCOUNTS BY PROFILE ----
accountsProfiles <- RJDBC::dbGetQuery(conn,queryAccountsProfiles)
accountsProfiles <- melt(accountsProfiles) %>% arrange(desc(value)) %>% mutate(variable=toupper(variable), variable=factor(variable, levels = variable[order(value, decreasing=T)]))
accountsProfiles$color <- NA
accountsProfiles$color[accountsProfiles$variable=='TOTAL_ACCOUNTS'] <- colorTot
accountsProfiles$color[accountsProfiles$variable=='RE_PROFILES'] <- colorRE
accountsProfiles$color[accountsProfiles$variable=='VJS_PROFILES'] <- colorVJS
accountsProfiles$color[accountsProfiles$variable=='CS_PROFILES'] <- colorCS
accountsProfiles$color[accountsProfiles$variable=='ERM_PROFILES'] <- colorERM
accountsProfiles$color[accountsProfiles$variable=='DASHBOARD_ONLY'] <- colorDash


chartProfile <- ggplot(data=accountsProfiles, aes(x=variable, y=value, fill = variable)) + 
                  geom_bar(aes(width=.75), position = position_dodge(width = .7), stat = "identity") +
                  #scale_fill_manual(values = accountsProfiles$color) +
                  geom_text(aes(label = value),  position=position_dodge(width=0.7), vjust = -1, size = 4, color = "#1A2D2E") +
                  scale_y_continuous(limit=c(0,max(accountsProfiles$value)*1.1)) +
                  chartTheme 
 
accountsProfiles$color <- NULL
colnames(accountsProfiles) <- toupper(colnames(accountsProfiles))


## ACCOUNTS BY ROLE
accountsByRole <- RJDBC::dbGetQuery(conn,queryAccountsByRole)
accountsByRole <- melt(accountsByRole) %>% arrange(desc(value)) %>% mutate(variable=toupper(variable), variable=factor(variable, levels = variable[order(value, decreasing=T)]))

chartRoles <- ggplot(data=accountsByRole, aes(x=variable, y=value, fill = variable)) + 
                  geom_bar(aes(width=.75), position = position_dodge(width = .7), stat = "identity") +
                  geom_text(aes(label = value),  position=position_dodge(width=0.7), vjust = -1, size = 4, color = "#1A2D2E") +
                  scale_y_continuous(limit=c(0,max(accountsByRole$value)*1.1)) +
                  chartTheme 
 
colnames(accountsByRole) <- toupper(colnames(accountsByRole))

