library(shiny)



  
shinyUI(
  
  fluidPage(

    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "chambertheme.css")
    ),  
 # tags$meta( "http-equiv"="Refresh", content="300"),

           
           navbarPage('MyHOH Overview',
                      tabPanel("Summary",
                                tabsetPanel('Name',
                                tabPanel('Account Analysis',
                                          dataTableOutput("profiles"),tags$br(),
                                          dataTableOutput("userRoles")
                                          ),
                                 tabPanel('Profile Overlap',
                                          plotOutput("overlap"),tags$br(),
                                          column(5,'NO OF PROFILES',tags$br(),dataTableOutput("noOfProfiles")),
                                          column(5, offset=1,'PROFILE OVERLAP',tags$br(),dataTableOutput("profileCombo"))
                                          ),
                                 tabPanel('Sign Up Trending',
                                          plotOutput("signupPlot")
                                          ),
                                 tabPanel('Google Analytics Summary',
                                          dataTableOutput("gaStats"),tags$br(),
                                          plotOutput("gaDailyPlot")
                                          )
                                 )),
                      tabPanel("Resume Engine",
                                tabsetPanel('Name',
                                 tabPanel('Resume Overview',
                                          dataTableOutput("reStats"),tags$br(),
                                          dataTableOutput("reCompletion")
                                          ),
                                 tabPanel('Business Stats Overview',
                                          dataTableOutput("reBizSummary"),tags$br(),
                                          column(5,'ALL BUSINESSESS',tags$br(),dataTableOutput("reBizStatsAll")),
                                          column(5, offset=1,'ACTIVE BUSINESSESS',tags$br(),dataTableOutput("reBizStatsActive")),tags$br(),
                                          dataTableOutput("reBizList")
                                          ),
                                 tabPanel('Top Sources | Pages | States',
                                          column(3,"TOP PAGES",tags$br(),dataTableOutput("pagesRE")),
                                          column(3, offset=1,"TOP STATES",tags$br(),dataTableOutput("statesRE")),
                                          column(3, offset=1,"TOP SOURCES",tags$br(),dataTableOutput("sourcesRE"))
                                          )
                                 )),
                      tabPanel("Career Spark",
                               tabsetPanel('Name',
                                 tabPanel('Resume Overview',
                                          dataTableOutput("csStats"),tags$br(),
                                          dataTableOutput("csCompletion")
                                          ),
                                 tabPanel('Top Sources | Pages | States',
                                          column(3,"TOP PAGES",tags$br(),dataTableOutput("pagesCS")),
                                          column(3, offset=1,"TOP STATES",tags$br(),dataTableOutput("statesCS")),
                                          column(3, offset=1,"TOP SOURCES",tags$br(),dataTableOutput("sourcesCS"))
                                          )
                                 )),
                      tabPanel("ERM",
                               tabsetPanel('Name',
                                 tabPanel('Article Stats',
                                          dataTableOutput("ermSummary"),
                                          dataTableOutput("ermArticleStats")
                                          ),
                                 tabPanel('Article Comments',
                                          dataTableOutput("ermComments")
                                          ),
                                 tabPanel('Top Sources | Pages | States',
                                          column(3,"TOP PAGES",tags$br(),dataTableOutput("pagesERM")),
                                          column(3, offset=1,"TOP STATES",tags$br(),dataTableOutput("statesERM")),
                                          column(3, offset=1,"TOP SOURCES",tags$br(),dataTableOutput("sourcesERM"))
                                          )
                                 )),
                      tabPanel("VJS",
                               tabsetPanel('Name',
                                 tabPanel('Overall Summary',
                                          dataTableOutput("vjsStats")
                                          ),
                                 tabPanel('Event Stats',
                                          dataTableOutput("vjsEventsStats")
                                          ),
                                 tabPanel('Top Sources | Pages | States',
                                          column(3,"TOP PAGES",tags$br(),dataTableOutput("pagesVJS")),
                                          column(3, offset=1,"TOP STATES",tags$br(),dataTableOutput("statesVJS")),
                                          column(3, offset=1,"TOP SOURCES",tags$br(),dataTableOutput("sourcesVJS"))
                                          )
                                 )),
                      tabPanel("Fast Track",
                               tabsetPanel('Name',
                                 tabPanel('Top Sources | Pages | States',
                                          column(3,"TOP PAGES",tags$br(),dataTableOutput("pagesFT")),
                                          column(3, offset=1,"TOP STATES",tags$br(),dataTableOutput("statesFT")),
                                          column(3, offset=1,"TOP SOURCES",tags$br(),dataTableOutput("sourcesFT"))
                                          )
                                 )),
                      tabPanel("All*Vet States",
                               tabsetPanel('Name',
                                 tabPanel('Top Sources | Pages | States', 
                                          column(3,"TOP PAGES",tags$br(),dataTableOutput("pagesAVS")),
                                          column(3, offset=1,"TOP STATES",tags$br(),dataTableOutput("statesAVS")),
                                          column(3, offset=1,"TOP SOURCES",tags$br(),dataTableOutput("sourcesAVS"))
                                          )
                                 ))

                      ) #end navbarPage
           


    

) ##fluidPage
) ##shinyUI



