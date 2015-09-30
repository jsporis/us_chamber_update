
### GA REQUEST - ga_overall_stats -----

ga_overall_stats <-  gaRequest2(
                                id=acct_list$PROFILE_ID,
                                metrics='ga:users,ga:sessions,ga:pageviews,ga:pageviewsPerSession,ga:avgSessionDuration', 
                                start=acct_list$LAUNCH_DATE,
                                end=date_end
                                )

ga_overall_stats <- merge(x=ga_overall_stats,y=acct_list,by.x='tableId',by.y="PROFILE_ID")

ga_overall_stats <- ga_overall_stats %>% 
                      select(ACCOUNT_NAME,LAUNCH_DATE,tableId,`start-date`,`end-date`,users,sessions,pageviews,pageviewsPerSession,avgSessionDuration) %>% 
                      mutate(
                            avgSessionDuration=round(avgSessionDuration),
                            avgSessionDuration=paste0(avgSessionDuration%/%60," minute(s) ",round(avgSessionDuration%%60),' seconds')
                            )



## GA REQUEST - ga_daily_session ------

ga_daily_sessions <- gaRequest(
                              id=acct_list$PROFILE_ID,
                              dimensions='ga:date',
                              metrics='ga:sessions', 
                              start=as.character(date_30),
                              end=date_end
                              )
ga_daily_sessions <- merge(x=ga_daily_sessions,y=acct_list,by.x='tableId',by.y="PROFILE_ID")
ga_daily_sessions <- ga_daily_sessions %>% select(ACCOUNT_NAME,date,sessions) %>% mutate(date=as.Date(date,'%Y%m%d'))

gaDaily <- ggplot(data=ga_daily_sessions, aes(x=date, y=sessions, group=ACCOUNT_NAME, color=ACCOUNT_NAME)) + geom_line(size=1.1) + chartTheme + scale_x_date(labels = date_format("%m/%d"), breaks=date_breaks("day"))



### GA REQUEST - MOBILE METRICS --------


tmp <-  gaRequest2(
          id=acct_list$PROFILE_ID,
          dimensions = 'ga:deviceCategory',
          metrics='ga:sessions',  
          start=acct_list$LAUNCH_DATE,
          end=date_end
)


tmp <- tmp %>% filter(deviceCategory!='desktop') %>% group_by(tableId) %>% summarize(mobileSessions=sum(sessions))


##ADD MOBILE METRICS TO OVERALL STATS
ga_overall_stats <- merge(x=ga_overall_stats,y=tmp,by.x='tableId',by.y="tableId")
rm(tmp)

##CALCULATE MOBILE PERCENT
ga_overall_stats$mobileSessions <- percent(ga_overall_stats$mobileSessions/ga_overall_stats$sessions)



### GA REQUEST - SOURCES -----

ga_sources <-  gaRequest2(
          id=acct_list$PROFILE_ID,
          dimensions='ga:sourceMedium',
          metrics='ga:sessions',  
          start=acct_list$LAUNCH_DATE,
          end=date_end,
          max=10,
          sort='-ga:sessions'
)
ga_sources <-  merge(x=ga_sources,y=acct_list,by.x='tableId',by.y="PROFILE_ID") %>% select(ACCOUNT_NAME,LAUNCH_DATE,tableId,`start-date`,`end-date`,sourceMedium,sessions)

### GA REQUEST - PAGES -----
ga_pages <-  gaRequest2(
          id=acct_list$PROFILE_ID,
          dimensions='ga:pagePath',
          metrics='ga:pageviews',  
          start=acct_list$LAUNCH_DATE,
          end=date_end,
          max=10,
          sort='-ga:pageviews',
          filters='ga:pagePath!=/'
)
ga_pages <- merge(x=ga_pages,y=acct_list,by.x='tableId',by.y="PROFILE_ID") %>% select(ACCOUNT_NAME,LAUNCH_DATE,tableId,`start-date`,`end-date`,pagePath,pageviews)

### GA REQUEST - STATES -----
ga_states <-  gaRequest2(
          id=acct_list$PROFILE_ID,
          dimensions='ga:region',
          metrics='ga:sessions',  
          start=acct_list$LAUNCH_DATE,
          end=date_end,
          max=10,
          sort='-ga:sessions'
)

ga_states <- merge(x=ga_states,y=acct_list,by.x='tableId',by.y="PROFILE_ID") %>% select(ACCOUNT_NAME,LAUNCH_DATE,tableId,`start-date`,`end-date`,region,sessions)


#### GA REQUEST - ERM SHARES AND PRINTS -------

s <- Sys.time()
#PULL SHARES
ermShares <- gaRequest(
  id=acct_list$PROFILE_ID[acct_list$ACCOUNT_NAME=='EMPLOYER ROAD MAP'], 
  metrics='ga:totalEvents',
  start=acct_list$LAUNCH_DATE[acct_list$ACCOUNT_NAME=='EMPLOYER ROAD MAP'], 
  end=date_end,
  filters='ga:eventLabel=@addthis'
  )$totalEvents
e <- Sys.time()
e-s

#PULL PRINTS
s <- Sys.time()
ermPrint <- gaRequest(
  id=acct_list$PROFILE_ID[acct_list$ACCOUNT_NAME=='EMPLOYER ROAD MAP'],  
  metrics='ga:totalEvents',
  start=acct_list$LAUNCH_DATE[acct_list$ACCOUNT_NAME=='EMPLOYER ROAD MAP'], 
  end=date_end,
  filters='ga:eventLabel=~^(/print/)'
)$totalEvents
e <- Sys.time()
e-s

## FINAL TWEAK

colnames(ga_overall_stats) <- toupper(colnames(ga_overall_stats))
ga_overall_stats$PAGEVIEWSPERSESSION <- round(ga_overall_stats$PAGEVIEWSPERSESSION,2)

colnames(ga_pages) <- toupper(colnames(ga_pages))
colnames(ga_sources) <- toupper(colnames(ga_sources))
colnames(ga_states) <- toupper(colnames(ga_states))

