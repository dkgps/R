# 나이 및 성별 월급 차이 (incomebyagebysex)
library(tidyverse)
library(sqldf)
library(plotly)

load("koweps/welfare.rda")
welfare %>% filter(!is.na(income)) %>% 
    group_by(age,sex) %>% 
    select(sex, age,income) %>% 
    summarise(mean=mean(income)) -> incomebysexbyage

ggplot(incomebysexbyage,aes(x=age, y=mean, fill=sex)) + 
    geom_col(position = "dodge") + 
    labs(x="연령대",y="평균 월급",fill="성별") 
