# Q4
## dplyr
midwest <- midwest %>% mutate(ratio_asian=(popasian/poptotal)*100)
midwest %>% select(state,county,ratio_asian) %>% arrange(ratio_asian) %>% head(10)

## sql
sqldf("select state, county, cast(popasian as float)/cast(poptotal as float) *100 
      as ratio_asian from midwest_sql order by ratio_asian limit 10")

## r syntax
(midwest_r$popasian/midwest_r$poptotal)*100 -> ratio_asian
midwest_r<- data.frame(midwest_r$state,midwest_r$county,ratio_asian)
midwest_r[order(midwest_r$ratio_asian),] -> midwest_r
midwest_r[1:10,]

