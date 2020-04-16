# 나이와 월급의 관계 incomebyage

library(tidyverse)
library(sqldf)
library(plotly)

load("koweps/welfare.rda")
summary(welfare)

table(is.na(welfare$birth)) # NA유무

welfare[order(welfare$birth), 'birth'] %>% head    # 극단치 유무
welfare[order(-welfare$birth), 'birth'] %>% head

qplot(x="group",y=birth, data=welfare, geom="boxplot")
qplot(x=birth, data=welfare, geom="histogram", breaks=seq(1900,2015,by=10))





# age 파생변수 만들기
welfare$age = 2016-welfare$birth+1
summary(welfare$age)
table(is.na(welfare$age))

welfare[order(welfare$age), 'age'] %>% head
welfare[order(-welfare$age), 'age'] %>% head

qplot(x="group",y=age, data=welfare, geom="boxplot")
qplot(x=age, data=welfare, geom="histogram", breaks=seq(0,110,by=10))


save(welfare, file="koweps/welfare.rda")

load("koweps/welfare.rda")


# income by age
#   ㄱ. 나이별 평균월급표 요약표 작성
welfare %>% filter(!is.na(income)) %>%  
    group_by(age) %>% 
    summarise(mean=mean(income)) -> incomebyage

#   ㄴ. 라인차트 그리기
ggplot(incomebyage,aes(age,mean))+geom_line()
ggplot(incomebyage,aes(age,mean))+geom_point() 




