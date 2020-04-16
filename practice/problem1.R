library(dplyr)
library(ggplot2)

# 문제1
df_midwest <-as.data.frame(ggplot2::midwest)
head(df_midwest,10)
tail(df_midwest,10)
dim(df_midwest)
str(df_midwest)
View(df_midwest)
summary(df_midwest)

# 문제2
rename(df_midwest, total=poptotal, asian=popasian) -> df_midwest

# 문제3
df_midwest$asian_ratio <- (df_midwest$asian/df_midwest$total)*100
hist(df_midwest$asian_ratio)

# 문제4
df_midwest$asian_pop <- ifelse(df_midwest$asian_ratio > mean(df_midwest$asian_ratio), "large",'small')

# 문제5
table(df_midwest$asian_pop)
qplot(df_midwest$asian_pop)
