#### MYHOH USER DATAFRAME BUILD ------

queryOverlap <- paste0(readLines('./sql/accounts_overlap.sql', warn=FALSE), collapse=' ')


overlap <- RJDBC::dbGetQuery(conn,queryOverlap)



### MYHOH USER OVERLAPP ANALYSIS ------


profile_count_summary <- overlap %>% mutate(total_profiles = cs_profiles+re_profiles+erm_profiles+vjs_profiles)

profile_count_summary <- profile_count_summary %>% group_by(total_profiles) %>% summarize(count=length(total_profiles)) %>% mutate(percent=percent(count/sum(count)))
colnames(profile_count_summary) <- c('NUMBER OF PROFILES', 'COUNT','PERCENT')

venn.plot <- venn(overlap[,c('cs_profiles','erm_profiles','re_profiles','vjs_profiles')], showSetLogicLabel = FALSE, show.plot=FALSE)

rm(overlap)



account_combinations <- data.frame(venn.plot[2:16,1:5], row.names=NULL)
account_combinations$no.of.accounts <- account_combinations[,2]+account_combinations[,3]+account_combinations[,4]+account_combinations[,5]

account_combinations$vjs_profiles[account_combinations$vjs_profiles==1] <- " |VJS| "
account_combinations$erm_profiles[account_combinations$erm_profiles==1] <- " |ERM| "
account_combinations$cs_profiles[account_combinations$cs_profiles==1] <- " |CS| "
account_combinations$re_profiles[account_combinations$re_profiles==1] <- " |RE| "
account_combinations$group <- paste0(account_combinations[,2],account_combinations[,3],account_combinations[,4],account_combinations[,5])
account_combinations$group <- gsub("0", "", account_combinations$group)
account_combinations <- account_combinations %>% select(group,num) %>% arrange(desc(num)) %>% mutate(percent=percent(num/sum(profile_count_summary$COUNT)))




