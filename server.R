#!/usr/bin/env Rscript

shinyServer(function(input, output, session) {

  start <- Sys.time()
  source("data_load/set_up.R")
  source("data_load/db_user_update.R")
  source("data_load/ga_data_load.R")
  source("data_load/db_erm_stats.R")
  source("data_load/db_vjs_stats.R")
  source("data_load/db_cs_load.R")
  source("data_load/db_resume_engine_load.R")
  source("data_load/db_overview_load.R")
  source("data_load/overlap.R")
end <- Sys.time()
end-start
  
output$cTime <- renderText(Sys.time())

## OVERALL STATS

output$userRoles <- renderDataTable( 
  accountsByRole, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$profiles <- renderDataTable( 
  accountsProfiles, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)


output$signupPlot <- renderPlot({
  print(signupDaily)
})

### OVERLAP ANALYSIS
output$profileCombo <- renderDataTable( 
  account_combinations, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$noOfProfiles <- renderDataTable( 
  profile_count_summary, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$overlap <- renderPlot({
  plot(venn.plot)
})

## GA DATA

output$gaStats <- renderDataTable( 
  ga_overall_stats[,c('ACCOUNT_NAME','start-date','end-date','users','sessions','pageviews','pageviewsPerSession','avgSessionDuration','mobileSessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$gaDailyPlot <- renderPlot({
  print(gaDaily)
})


##Resume engine
output$reStats <- renderDataTable( 
  re_resume_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$reCompletion <- renderDataTable( 
  re_resume_completion, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$reBizSummary <- renderDataTable( 
  re_biz_stats_summary, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$reBizStatsAll <- renderDataTable( 
  re_statistic_all_business, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$reBizStatsActive <- renderDataTable( 
  re_statistic_active_business, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$reBizList <- renderDataTable( 
  re_business_list, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

## EMPLOYER ROAD MAP

output$ermSummary <- renderDataTable( 
  erm_summary, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$ermArticleStats <- renderDataTable( 
  erm_article_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$ermComments <- renderDataTable( 
  erm_article_comments, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)


### CAREER SPARK
output$csStats <- renderDataTable( 
  cs_resume_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$csCompletion <- renderDataTable( 
  cs_resume_completion, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

### VJS
output$vjsStats <- renderDataTable( 
  vjs_overall_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$vjsEventsStats <- renderDataTable( 
  vjs_event_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

#### ga page path --------
output$pagesRE <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='RESUME ENGINE', c('pagePath','pageviews')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesCS <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='CAREER SPARK', c('pagePath','pageviews')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesAVS <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='ALL*VET STATES', c('pagePath','pageviews')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesVJS <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='VIRTUAL JOB SCOUT', c('pagePath','pageviews')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesERM <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='EMPLOYER ROAD MAP', c('pagePath','pageviews')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesFT <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='FAST TRACK', c('pagePath','pageviews')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)


#### ga sources path --------
output$sourcesRE <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='RESUME ENGINE', c('sourceMedium','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesCS <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='CAREER SPARK', c('sourceMedium','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesAVS <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='ALL*VET STATES', c('sourceMedium','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesVJS <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='VIRTUAL JOB SCOUT', c('sourceMedium','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesERM <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='EMPLOYER ROAD MAP', c('sourceMedium','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesFT <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='FAST TRACK', c('sourceMedium','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

#### ga states --------
output$statesRE <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='RESUME ENGINE', c('region','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesCS <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='CAREER SPARK', c('region','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesAVS <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='ALL*VET STATES', c('region','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesVJS <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='VIRTUAL JOB SCOUT', c('region','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesERM <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='EMPLOYER ROAD MAP', c('region','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesFT <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='FAST TRACK', c('region','sessions')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)





#output$userPlot <- renderPlot({
  
#  print(chart1)
  
#})




})
