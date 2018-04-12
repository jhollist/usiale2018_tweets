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
load("usiale2018.rda")
View(usiale2018)

library(wesanderson)
library(tidyverse)
library(stringr)
library(magick)
library(tidytext)
library(widyr)
library(rvest)

"print.magick-image" <- function(x, ...){
  ext <- ifelse(length(x), tolower(image_info(x[1])$format), "gif")
  tmp <- tempfile(fileext = paste0(".", ext))
  image_write(x, path = tmp)
  knitr::include_graphics(tmp)
}


tw <- usiale2018 %>%
  distinct(status_id, .keep_all = TRUE)

top_fav <- tw %>%
  filter(!is_retweet) %>%
  top_n(20, favorite_count) %>%
  arrange(desc(favorite_count))
View(top_fav)

top_users <- tw %>%
  group_by(screen_name) %>%
  summarize(total_tweets = n(),
            retweet = sum(is_retweet),
            original = sum(!is_retweet)) %>%
  top_n(30, total_tweets) %>%
  gather(type, n_tweets, -screen_name, -total_tweets)

top_users$screen_name <- reorder(top_users$screen_name,
                                 top_users$total_tweets,
                                 function(x) sum(x))

ggplot(top_users) + geom_bar(aes(x = screen_name, y = n_tweets, fill = type),
                             stat = "identity") +
  ylab("Number of tweets") + xlab("User") +
  coord_flip() +
  scale_fill_manual(values = wes_palette("Zissou")[c(1, 3)]) +
  theme(axis.text = element_text(size = 12),
        legend.text = element_text(size = 12))
