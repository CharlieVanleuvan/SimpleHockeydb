#load the odbc package
library(RODBC)
library(ggplot2)

#create a connection to SQLserver
connection <- odbcConnect("IST659HockeyDB")

sqlScript <- "select * from TopGoalScorer order by TotalGoals desc"

#send the sql request to SQLServer and store the resulting table output in df
df <- sqlQuery(connection,sqlScript)

#select just the top 5 goal scorers
df <- df[0:5,]

#add a column that is a concatenation of FirstName and LastName
df$Name <- paste(df$FirstName,df$LastName)

barplot(df$TotalGoals,
        main="Scoring Leaders",
        xlab="Name",
        ylab="Goals",
        border="blue",
        col="orange",
        names.arg=df$Name)


#close all connections
odbcCloseAll()
