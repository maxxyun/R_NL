# 독립 두 표본의 평균비교

data <- read.csv(file="./R 기초/D3/data/indep_t_test.csv",
                 header=TRUE)
str(data)

# 분산의 동일성 검증
# H0 : 분산은 동일하다
# H1 : 분산은 동알하지 않다

var.test(data$weight ~ data$gender )

# 분산이 동일할 때 : 독립표본 t-test
# 대안가설 : 남아와 여아의 몸무게 평균이 다르다.
# alternative = "two.sided"

t.test(data$weight ~ data$gender,
       var.equal=TRUE,
       nu=0)

library(tidyverse)

data %>%
    group_by(gender) %>%
    summarise(
        n=n(),
        m=mean(weight),
        s=sd(weight)
    )

# h1 : 남아의 몸무게가 더 무겁다.
t.test(data$weight ~ data$gender,
       var.equal=TRUE,
       alternative="less",
       mu=0)


# 두 집단의 분산이 서로 다르다면
t.test(data$weight ~ data$gender,
       var.equal=FALSE,
       alternative="less",
       mu=0)


t.test(data$weight ~ data$gender,
       alternative="less",
       mu=0)
