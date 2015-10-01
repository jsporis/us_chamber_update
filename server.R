#!/usr/bin/env Rscript

  source("data_load/set_up.R")
  source("data_load/function.R")

shinyServer(function(input, output, session) {


  source("data_load/db_user_update.R")
  source("data_load/ga_data_load.R")
  source("data_load/db_erm_stats.R")
  source("data_load/db_vjs_stats.R")
  source("data_load/db_cs_load.R")
  source("data_load/db_resume_engine_load.R")
  source("data_load/db_overview_load.R")
  source("data_load/overlap.R")

output$cTime <- renderText(Sys.time())

## OVERALL STATS

output$userRoles <- renderDataTable( 
  accountsByRole, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$profiles <- renderDataTable( 
  accountsProfiles, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$profilePlot <- renderPlot({
  print(chartProfile)
})

output$rolePlot <- renderPlot({
  print(chartRoles)
})

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
  ga_overall_stats[,c('ACCOUNT_NAME','START-DATE','END-DATE','USERS','SESSIONS','PAGEVIEWS','PAGEVIEWSPERSESSION','AVGSESSIONDURATION','MOBILESESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$gaDailyPlot <- renderPlot({
  print(gaDaily)
})


##Resume engine
output$reStats <- renderDataTable( 
  re_resume_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$reCompletionPlot <-renderPlot({
  print(chartREcomplete)
})

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
  re_business_list, options = list(bFilter = TRUE, bPaginate = TRUE, bAutoWidth = TRUE, pageLength=10)
)

output$downloadList <- downloadHandler(
  filename = function() {
    paste('re_business_list', Sys.Date(), '.csv', sep="_")
  },
  content = function(file) {
    write.csv(re_business_list, file)
  }
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

output$csCompletionPlot <-renderPlot({
  print(chartCScomplete)
})

### VJS
output$vjsStats <- renderDataTable( 
  vjs_overall_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$vjsEventsStats <- renderDataTable( 
  vjs_event_stats, options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$participantList <- downloadHandler(
  filename = function() {
    paste('vjs_event_participants', Sys.Date(), '.csv', sep="_")
  },
  content = function(file) {
    write.csv(vjs_event_participants, file)
  }
)



#### ga page path --------
output$pagesRE <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='RESUME ENGINE', c('PAGEPATH','PAGEVIEWS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesCS <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='CAREER SPARK', c('PAGEPATH','PAGEVIEWS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesAVS <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='ALL*VET STATES', c('PAGEPATH','PAGEVIEWS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesVJS <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='VIRTUAL JOB SCOUT', c('PAGEPATH','PAGEVIEWS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesERM <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='EMPLOYER ROAD MAP', c('PAGEPATH','PAGEVIEWS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$pagesFT <- renderDataTable( 
  ga_pages[ga_pages$ACCOUNT_NAME=='FAST TRACK', c('PAGEPATH','PAGEVIEWS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)


#### ga sources path --------
output$sourcesRE <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='RESUME ENGINE', c('SOURCEMEDIUM','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesCS <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='CAREER SPARK', c('SOURCEMEDIUM','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesAVS <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='ALL*VET STATES', c('SOURCEMEDIUM','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesVJS <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='VIRTUAL JOB SCOUT', c('SOURCEMEDIUM','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesERM <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='EMPLOYER ROAD MAP', c('SOURCEMEDIUM','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$sourcesFT <- renderDataTable( 
  ga_sources[ga_sources$ACCOUNT_NAME=='FAST TRACK', c('SOURCEMEDIUM','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

#### ga states --------
output$statesRE <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='RESUME ENGINE', c('REGION','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesCS <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='CAREER SPARK', c('REGION','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesAVS <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='ALL*VET STATES', c('REGION','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesVJS <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='VIRTUAL JOB SCOUT', c('REGION','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesERM <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='EMPLOYER ROAD MAP', c('REGION','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)

output$statesFT <- renderDataTable( 
  ga_states[ga_states$ACCOUNT_NAME=='FAST TRACK', c('REGION','SESSIONS')], options = list(bFilter = FALSE, bPaginate = FALSE, bAutoWidth = TRUE)
)





#output$userPlot <- renderPlot({
  
#  print(chart1)
  
#})




})
