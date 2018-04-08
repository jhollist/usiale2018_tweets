#devtools::install_github("ThinkR-open/tweetstorm")
library(tweetstorm)
library(rtweet)
library(dplyr)
create_token("usiale2018", 
             Sys.getenv("usiale2018_key"),
             Sys.getenv("usiale2018_secret"))
#x<-rtweet::search_tweets("#usiale2018",n = 500)
#save(x, file = "usiale2018.rda")
load("usiale2018.rda")
x<-tweetstorm:::update_search(x,"#usiale2018")
save(x,file="usiale2018.rda")
load("usiale2018.rda")
View(x)
