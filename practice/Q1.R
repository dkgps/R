library(tidyverse)
library(sqldf)

# Q1
## dplyr
midwest <- as.data.frame(ggplot2::midwest)
midwest <- midwest %>% mutate(ratio_child=(poptotal-popadults)/poptotal*100) 
midwest 

## sqldf
midwest_sql <- as.data.frame(ggplot2::midwest)
midwest_sql <-sqldf("select *, cast((poptotal-popadults) as float)/cast(poptotal as float) *100 as ratio_child from midwest")
midwest_sql

## r syntax
midwest_r <- as.data.frame(ggplot2::midwest)
(midwest_r$poptotal-midwest_r$popadults)/midwest_r$poptotal*100 -> ratio_child
midwest_r<- data.frame(midwest_r,ratio_child)
midwest_r
