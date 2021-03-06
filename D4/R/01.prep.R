install.packages("tidyverse")
install.packages("readxl")

library(tidyverse)
library(readxl)
data<-read_excel("./D4/data/ex_data.xlsx")
data
dim(data)       #행과 열의 갯수를 알려줌
names(data)     #열의 이름을 알려줌
str(data)       #행과 열의 갯수, 열의 이름과 종류들을 알려줌

itv<-c(0,25,30,35,40,Inf)       #0, 25, 30, 35, 40, inf 6개 행렬을 만든다
cut(data$age,itv)               #나이를 itv로 자른다


data %>%                            #mutate = 새로운 열을 만든다. 하지만
    mutate(age_cat=cut(age,itv))    #만들지만 저장하지는 않음

data<-data %>%                      #만들어진 열을 data에 저장
    mutate(age_cat=cut(age,itv))

data

view(data)


levels(data$age_cat)

data$country
factor(data$country,
       levels=c(1,2),                 #기존 데이터
       labels=c("A","B"))             #변경할 라벨

levels(data$age_cat)
data <- data %>%
    mutate(
        age_cat=factor(age_cat,
                       levels=levels(data$age_cat),
                       labels=c("20대 초반", "20대 후반",
                                "30대 초반", "30대 후반", 
                                "40세 이상")
                       )
        )

view(data)

data<-data %>%
    mutate(
        cntr_name=factor( country,    #data$country가 필요없음. 위에 %>% 때문에
                           levels=c(1,2),         #기존 데이터
                           labels=c("A","B")      #변경할 라벨
                        )
        )


#jobs의 1,2를 각 무직과 취업으로 변경
data <- data %>%
    mutate(
        jobs=factor(jobs,
                    levels=c(1,2),
                    labels=c("무직","취업")
                   )
    )


#교육정도 중졸이하, 고졸, 대졸
str(data)       #행과 열의 갯수, 열의 이름과 종류들을 알려줌
factor(data$edu.level)  #열에 데이터 종류를 알려줌
data<-data %>%
    mutate(
        
    )

#소득 150만원 이하, 150~200만원, 200만원대, 300만원 이상



#행별, 열별 정리
data
data %>%
    rowwise()

mean(data$age)

data %>%
    rowwise() %>%
    mutate(
        a_mean=mean(c_across(starts_with("A_")    
#A_로 시작하는열을 c_across로 열을 가로질러 mean으로 평균을 구해 a_mean열에 넣는다.rowwise로 열별로 작동하게 한다
                             )
                    )
    ) %>%
    view()
    )

data <- data %>%
    rowwise() %>%
    mutate(
        A_mean=mean(c_across(starts_with("A_"))),
        B_mean=mean(c_across(starts_with("B_"))),
        C_mean=mean(c_across(starts_with("C_")))
    )


#sd표준편차
data <- data %>%
    rowwise() %>%
    mutate(
        A_sd=sd(c_across(starts_with("A_"))),
        B_sd=sd(c_across(starts_with("B_"))),
        C_sd=sd(c_across(starts_with("C_")))
    )


#분석에 필요한 것들만 골라냄 select
data %>%
    select("no","age", jobs:income,age_cat:C_sd)    #job부터 income까지

a_data <-data %>%
    select("no","age", jobs:income,age_cat:C_sd)

#저장
saveRDS(a_data, "./D4/data/a_data.rds")


#교차분석 국가별 취험여부
table(data$cntr_name,data$jobs)

tab1<-table(data$cntr_name,data$jobs)

#교차표 비율
#전체 비율
prop.table(tab1)

#행 비율. 행이 100%. A 국가에 무직자와 취업자 비율
prop.table(tab1, margin = 1)

#열 비율. 열이 100%. 무직자 중 A국가와 B국가 비율
prop.table(tab1, margin = 2)

#퍼센트로
100*prop.table(tab1, margin = 1)

#반올림해서 소숫점 1자리로 표시
round(100*prop.table(tab1, margin = 1),1)

#DescTools 설치. 기초통계랑을 편하게 보여줌
install.packages("DescTools")
library(DescTools)

PercTable(cntr_name~jobs, data=a_data,
          rfrq="010", margin=1)         #rfrq=전체, 행, 열 on/off



tab_age<-table(data$cntr_name,data$age_cat)
tab_age

#주사위를 12번 던졌다 치고 랜덤하게 나오게
sample(1:6,12,replace = TRUE)
table(sample(1:6,12,replace=TRUE))


#카이제곱 검정. 범주형 자료들의 동일성 검정
chisq.test(tab_age)     #열이 너무 많다. 나이대를 합치자

#기대 빈도
ta_result <-chisq.test(tab_age)
ta_result$expected
ta_result$observed
ta_result$p.value
names(ta_result)        #뭐가 있나 보자


#거주기간
a_data %>%
    group_by(cntr_name) %>%
    summarise(
        m=mean(duration),
        sd=sd(duration),
        n=n()
    )


#두 집단의 평균 검정
#분산의 동일성 검증
var.test(a_data$duration~a_data$cntr_name)  #두 집단의 분산이 같지않음

t.test(a_data$duration~a_data$cntr_name,
       var.equal=FALSE,
       alternative="two.sided")

#범주형은 카이제곱 X^2
#연속형 ttest