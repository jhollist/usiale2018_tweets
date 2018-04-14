#devtools::install_github("ThinkR-open/tweetstorm")
library(tweetstorm)
library(rtweet)
library(dplyr)
create_token("usiale2018", 
             Sys.getenv("usiale2018_key"),
             Sys.getenv("usiale2018_secret"))
#usiale2018<-rtweet::search_tweets("#usiale2018",n = 500)
#save(usiale2018, file = "usiale2018.rda")
load("usiale2018.rda")
usiale2018<-tweetstorm:::update_search(usiale2018,"#usiale2018",n=1000)
save(usiale2018,file="usiale2018.rda")
