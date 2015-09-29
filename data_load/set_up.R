require(ggplot2)
require(gplots)
require(shiny)
require(reshape2)
require(RJDBC)
require(scales)
require(GAR)
require(dplyr)
require(data.table)
require(rmongodb)

## ESTABLISH CONNECTIONS ------
tokenRefresh()

mysql_jar <- '../source_files/mysql-connector-java-5.1.24-bin.jar'

drv <- JDBC("com.mysql.jdbc.Driver",mysql_jar,identifier.quote="`")

conn <- dbConnect(drv, Sys.getenv('IO_DB_03RJDBC'), Sys.getenv('IO_DB_USER'), Sys.getenv('IO_DB_PW'))
connUpdate <- dbConnect(drv, Sys.getenv('IO_DB_03RJDBC'), Sys.getenv('IO_DB_WRITE_USER'), Sys.getenv('IO_DB_WRITE_PW'))

mongo <- mongo.create(host=paste(Sys.getenv('MONGO_HOST'), Sys.getenv('MONGO_PORT'),sep=':'), username=Sys.getenv('MONGO_UN'), password=Sys.getenv('MONGO_PW'), db="career_spark")

###CREATE ACCOUNT LIST DF -----

acct_list <- data.frame(
  ACCOUNT_NAME=c("CAREER SPARK","EMPLOYER ROAD MAP","RESUME ENGINE","VIRTUAL JOB SCOUT","MYHOH","FAST TRACK","ALL*VET STATES"),
  LAUNCH_DATE=c("2014-03-24","2014-08-12","2013-03-27","2014-08-12","2015-06-22","2015-04-06","2014-03-20"),
  PROFILE_ID=c("ga:83125551","ga:86723611","ga:69696678","ga:85221727","ga:104246206", "ga:95074076","ga:83651841")
  , stringsAsFactors=FALSE)

acct_list$START_DATE <- as.Date(acct_list$LAUNCH_DATE)

###SET PRIOR DATE -----
date_end <- as.character(Sys.Date()-1)
date_30 <- Sys.Date()-30

#date_week_prior <- as.character(Sys.Date()-7)


## COLORS

colorDash <- '#39ABA8'
colorRE <- '#0572AA'
colorVJS <- '#48A465'
colorCS <- '#11A8AB'
colorERM <- '#21CAA4'
colorFT <- '#164350'
colorAVS <- '#5680BB'
colorTot <- '#325481'

##CHART THEME
chartTheme <-  theme(
    text=element_text(color="#1A2D2E"),
    axis.line=element_blank(),
    axis.ticks=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_text(size = 10),
    axis.text.x=element_text(size = 12,  angle=90),
    axis.title.x=element_blank(),
    legend.position="top",
    legend.text=element_text(size = 10),
    legend.title=element_blank(),
    panel.border=element_blank(),
    panel.background=element_blank(),
    plot.background=element_blank())



