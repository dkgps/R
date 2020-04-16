# Q3
## dplyr
midwest <- midwest %>% mutate(grade=ifelse(ratio_child>=40,"large",
                                           ifelse(ratio_child>=30,"middle","small")))
midwest
table(midwest$grade)

#sql
sqldf("select county,ratio_child,
        case when ratio_child >=40 then 'large'
              when ratio_child >=30 then 'middle'
              else 'small'
            end as grade
      from midwest_sql") ->mid_grade
mid_grade

sqldf("select count(*) as large from mid_grade where grade ='large'") ->large
sqldf("select count(*) as middle from mid_grade where grade ='middle'") ->middle
sqldf("select count(*) as small from mid_grade where grade ='small'") ->small
sqldf("select * from large join middle join small")


## r syntax

midwest_r$grade<- ifelse(midwest_r$ratio_child>=40, "large",
                         ifelse(midwest_r$ratio_child >=30, "middle","small"))
table(midwest_r$grade)


