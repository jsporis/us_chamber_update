library(shiny)



  
shinyUI(
  
  fluidPage(

    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "chambertheme.css")
    ),  
 # tags$meta( "http-equiv"="Refresh", content="300"),

           
           navbarPage('MyHOH Internal Dashboard',
                      tabPanel("Summary",
                                tabsetPanel('Name',
                                tabPanel(span(id='tab','Account Analysis'),
                                         tags$p(),
                                          fluidRow(id='label','ACCOUNTS AND PROFILES'),tags$br(),
                                            fluidRow(
                                            column(4,dataTableOutput("profiles")),
                                            column(8,plotOutput('profilePlot'))
                                            ),
                                         hr(),
                                          fluidRow(id='label','ACCOUNTS BY ROLE'),
                                            fluidRow(
                                            column(4,dataTableOutput("userRoles")),
                                            column(8,plotOutput('rolePlot'))
                                          )),
                                 tabPanel(span(id='tab','Profile Overlap'),
                                          tags$p(),
                                          fluidRow(id='label','VENN DIAGRAM'),
                                          column(8, offset=2,plotOutput("overlap")),tags$br(),
                                          fluidRow(
                                          hr(),
                                          column(5,
                                                fluidRow(id='label','NO OF PROFILES'),tags$br(),
                                                dataTableOutput("noOfProfiles")
                                                ),
                                          column(6,offset=1,
                                                fluidRow(id='label','PROFILE COMBINATIONS'),tags$br(),
                                                dataTableOutput("profileCombo")
                                                ))),
                                 tabPanel(span(id='tab','Sign Up Trending'),
                                          tags$p(),
                                          fluidRow(id='label','ACCOUNT SOURCE BY DAY (PRIOR 30)'),tags$br(),
                                          plotOutput("signupPlot")
                                          ),
                                 tabPanel(span(id='tab','Google Analytics Summary'),
                                          tags$p(),
                                          fluidRow(12,id='label','WEB SESSIONS BY DAY (PRIOR 30)'),tags$br(),
                                                  plotOutput("gaDailyPlot"),
                                          hr(),
                                          fluidRow(id='label','OVERALL WEB STATS'),
                                                  dataTableOutput("gaStats")
                                          )
                                 )),
                      tabPanel("Resume Engine",
                                tabsetPanel('Name',
                                 tabPanel(span(id='tab','Resume Overview'),
                                          tags$p(),
                                          fluidRow(
                                            column(4,
                                                  fluidRow(id='label','RE OVERVIEW'),tags$br(),
                                                  dataTableOutput("reStats")
                                                  ),
                                            column(7,offset=1,
                                                  fluidRow(id='label','RE COMPLETION'),tags$br(),
                                                  plotOutput("reCompletionPlot")
                                                  )
                                          )),
                                 tabPanel(span(id='tab','Business Stats Overview'),
                                          tags$p(),
                                          fluidRow(id='label','BUSINESS STAT OVERVIEW'),tags$br(),
                                            dataTableOutput("reBizSummary"),
                                          hr(),
                                            fluidRow(
                                            column(5,
                                                   fluidRow(id='label', 'ALL BUSINESSESS'),tags$br(),
                                                   dataTableOutput("reBizStatsAll")
                                                   ),
                                            column(5, offset=2,
                                                   fluidRow(id='label', 'ACTIVE BUSINESSESS'),tags$br(),
                                                   dataTableOutput("reBizStatsActive")
                                                   )
                                                  ),
                                          hr(),
                                          fluidRow(id='label', 'BUSINESS LIST'),tags$br(),
                                          dataTableOutput("reBizList")
                                          ),
                                 tabPanel(span(id='tab','Top Sources | Pages | States'),
                                          tags$p(),
                                          column(3,
                                                 fluidRow(id='label', 'TOP SOURCES'),tags$br(),
                                                 dataTableOutput("pagesRE")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP PAGES'),tags$br(),
                                                 dataTableOutput("statesRE")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP STATES'),tags$br(),
                                                 dataTableOutput("sourcesRE")
                                                 )
                                          )
                                 )),
                      tabPanel("Career Spark",
                               tabsetPanel('Name',
                                 tabPanel(span(id='tab','Resume Overview'),
                                          tags$p(),
                                          fluidRow(
                                            column(4,
                                                  fluidRow(id='label','RE OVERVIEW'),tags$br(),
                                                  dataTableOutput("csStats")
                                                  ),
                                            column(7,offset=1,
                                                  fluidRow(id='label','RE COMPLETION'),tags$br(),
                                                  plotOutput("csCompletionPlot")
                                                  )
                                          )),                  
                                 tabPanel(span(id='tab','Top Sources | Pages | States'),
                                          tags$p(),
                                          column(3,
                                                 fluidRow(id='label', 'TOP SOURCES'),tags$br(),
                                                 dataTableOutput("pagesCS")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP PAGES'),tags$br(),
                                                 dataTableOutput("statesCS")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP STATES'),tags$br(),
                                                 dataTableOutput("sourcesCS")
                                                 )
                                          )
                                 )),
                      
                      tabPanel("ERM",
                               tabsetPanel('Name',
                                 tabPanel(span(id='tab','Article Stats'),
                                          tags$p(),
                                          fluidRow(id='label', 'ERM SUMMARY STATS'), tags$br(),
                                          dataTableOutput("ermSummary"), tags$br(),
                                          hr(),
                                          fluidRow(id='label', 'ERM ARTICLE STATS'), tags$br(),
                                          dataTableOutput("ermArticleStats")
                                          ),
                                 tabPanel(span(id='tab','Article Comments'),
                                          tags$p(),
                                          fluidRow(id='label', 'COMMENTS'), tags$br(),
                                          dataTableOutput("ermComments")
                                          ),
                                 
                                 tabPanel(span(id='tab','Top Sources | Pages | States'),
                                          tags$p(),
                                          column(3,
                                                 fluidRow(id='label', 'TOP SOURCES'),tags$br(),
                                                 dataTableOutput("pagesERM")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP PAGES'),tags$br(),
                                                 dataTableOutput("statesERM")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP STATES'),tags$br(),
                                                 dataTableOutput("sourcesERM")
                                                 )
                                          )
                                 )),
                      tabPanel("VJS",
                               tabsetPanel('Name',
                                 tabPanel(span(id='tab','Overall Summary'),
                                          tags$p(),
                                          fluidRow(id='label', 'OVERALL'), tags$br(),
                                          column(5,dataTableOutput("vjsStats"))
                                          ),
                                 tabPanel(span(id='tab','Event Stats'),
                                          tags$p(),
                                          fluidRow(id='label', 'EVENTS'), tags$br(),
                                          dataTableOutput("vjsEventsStats")
                                          ),
                                 tabPanel(span(id='tab','Top Sources | Pages | States'),
                                          tags$p(),
                                          column(3,
                                                 fluidRow(id='label', 'TOP SOURCES'),tags$br(),
                                                 dataTableOutput("pagesVJS")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP PAGES'),tags$br(),
                                                 dataTableOutput("statesVJS")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP STATES'),tags$br(),
                                                 dataTableOutput("sourcesVJS")
                                                 )
                                          )
                                 )),
                      tabPanel("Fast Track",
                               tabsetPanel('Name',
                                 tabPanel(span(id='tab','Top Sources | Pages | States'),
                                          tags$p(),
                                          column(3,
                                                 fluidRow(id='label', 'TOP SOURCES'),tags$br(),
                                                 dataTableOutput("pagesFT")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP PAGES'),tags$br(),
                                                 dataTableOutput("statesFT")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP STATES'),tags$br(),
                                                 dataTableOutput("sourcesFT")
                                                 )
                                          )           
                                 )),
                      tabPanel("All*Vet States",
                               tabsetPanel('Name',
                                           
                                 tabPanel(span(id='tab','Top Sources | Pages | States'),
                                          tags$p(),
                                          column(3,
                                                 fluidRow(id='label', 'TOP SOURCES'),tags$br(),
                                                 dataTableOutput("pagesAVS")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP PAGES'),tags$br(),
                                                 dataTableOutput("statesAVS")
                                                 ),
                                          column(3, offset=1,
                                                 fluidRow(id='label', 'TOP STATES'),tags$br(),
                                                 dataTableOutput("sourcesAVS")
                                                 )
                                          ) 
                                 ))

                      ) #end navbarPage
           


    

) ##fluidPage
) ##shinyUI



