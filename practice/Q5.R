# 성별에 따른 월급 차이 (incomebysex)
library(tidyverse)
library(foreign)



read.dta("koweps/Koweps_hpwc11_2016_beta2.dta") %>%
    rename(sex = h11_g3) %>%              
    rename(birth = h11_g4) %>%             
    rename(marriage = h11_g10) %>%         
    rename(religion = h11_g11) %>%       
    rename(code_job = h11_eco9) %>%      
    rename(income = p1102_8aq1) %>%       
    rename(code_region = h11_reg7) -> welfare     


welfare %<>% mutate(sex=ifelse(sex==1, "male", "female")) %>% 
    mutate(income=ifelse(income==0, NA, income)) %>% 
    select(sex, 
           birth, 
           marriage, 
           religion, 
           income, 
           code_job, 
           code_region) 

save(welfare, file="koweps/welfare.rda")

load("koweps/welfare.rda")
summary(welfare)


# sex
#   NA 확인
table(is.na(welfare$sex))
#   outlier, 빈도 확인
table(welfare$sex)
#   빈도 막대 그래프
library(plotly)
qplot(sex, data=welfare)


# income
#   NA 확인
table(is.na(welfare$income))

welfare %>% filter(!is.na(income)) %>% select(income) %>% arrange(income) %>% head(20)
welfare %>% filter(!is.na(income)) %>% select(income) %>% arrange(desc(income)) %>% head(20)

#   boxplot
### r base
boxplot(welfare$income)
### qplot
qplot(x="total",y=income,data=welfare,geom="boxplot")
### ggplot
ggplot(welfare,aes(y=income))+geom_boxplot()


table(welfare$income)
#   histogram - 200만원 단위
qplot(income,data=welfare,breaks=seq(0,3600, by=200))




# income by sex
### SQL
library(sqldf)
sqldf("select sex, avg(income) as mean from welfare group by sex")

### dplyr
welfare %>% group_by(sex) %>%  
    summarise(mean_income=mean(income, na.rm = T)) -> incomebysex 

ggplot(incomebysex,aes(sex,mean_income))+geom_col()










