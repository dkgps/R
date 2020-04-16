# Q2
## dplyr
midwest %>% arrange(desc(ratio_child)) %>% select(county,ratio_child) %>% head(5)

## sqldf
sqldf("select county, ratio_child 
      from midwest_sql
      order by ratio_child desc limit 5")

## r syntax
midwest_child <- data.frame(midwest_r$county,ratio_child)
midwest_child <- midwest_child[order(-midwest_child$ratio_child),]
midwest_child[1:5,]

