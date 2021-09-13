#install.packages("tidyverse")

qplot()
ggplot2::qplot()

library(tidyverse)
qplot()

pi<-read.csv("./R 기초/D2/data/PatientInfo.csv",
             header = TRUE,
             stringsAsFactors = FALSE)

pi
as_tibble(pi)       #앞에 10개 데이터만 보여줌

pi_tbl<-as_tibble(pi)

pi_tbl
view(pi_tbl)

class(pi_tbl)



#dplyr   '함수(대상 데이터프레임, 명령어)' 형식

#filter()   엑셀 필터랑 같음
filter(pi_tbl,state=="released")    # '='는 state에 released를 넣음. '=='이거가 논리 연산자로 같은거 찾는거
sr<-filter(pi_tbl,state=="released"&
           province=="Seoul")
filter(pi_tbl,state=="released"|
           province=="Seoul")


#select()
names(pi_tbl)

select(pi_tbl,1:3)              #첫번째 부터 3번째 까지 가지고 오기
select(pi_tbl,country:city)     #컨트리 열부터 씨티 열까지 가지고 오기
select(pi_tbl,age,city)         #age랑 city만 가져오기
select(pi_tbl,c(age,city))      #age랑 city만 가져오기 동일
select(pi_tbl,ends_with("date"))       #date로 끝나는 열 가지고 오기
select(pi_tbl,starts_with("infect"))    #infect로 시작하는 열 가지고 오기
select(pi_tbl,contains("da"))           #da가 들어가는 열 가지고 오기


#mutate()

"abc"
"def"
paste("abc","def",sep="_")      #문자를 '_'사이에 넣어 합치기

mutate(pi_tbl,sex_age=paste(sex,age,sep="_"))       #(df,만들 열 이름=paste(붙일거,붙일거, 어떻게 붙일지))
                                                    #열 마지막에 붙임
transmute(pi_tbl,sex_age=paste(sex,age,sep="_"))    #합친것만 빼서 만들기


#arrange()
arrange(pi_tbl,province)            #오름차순 정렬이 기본
arrange(pi_tbl,desc(province))      #내림 차순 정렬
arrange(pi_tbl,province,desc(age))  #1차조건 2차조건 province 오름차순 정렬 후에 나이 내림차순 정렬


#summarise()
#mutate_at()
pi_tbl2<-mutate_at(pi_tbl,
                   .vars=vars(ends_with("date")),
                   .funs=list(dt=as.Date))
view(pi_tbl2)
pi_tbl2

pi_tbl2<-mutate(pi_tbl2,
                dur=released_date_dt-confirmed_date_dt)     #완치날짜-확진날짜=dur

summarise(pi_tbl2,
          dur_mean=mean(dur,na.rm=TRUE))    #na.rm=TRUE는 결측값 처리

mean(pi_tbl2$dur,na.rm=TRUE)                #이거랑 위에랑 똑같음.

pi_tbl2_grp <- group_by(pi_tbl2,sex)        #성별을 그룹으로 나눔
pi_tbl2_grp
summarise(pi_tbl2_grp,
          dur_mean=mean(dur,na.rm=TRUE))    #남여 성별 별로 평균

summarise(pi_tbl2_grp,
          dur_mean=mean(dur,na.rm=TRUE),
          dur_sd=sd(dur,na.rm=TRUE))        #표준편차도 구해줌

summarise(pi_tbl2_grp,
          n=n(),
          dur_mean=mean(dur,na.rm=TRUE),
          dur_sd=sd(dur,na.rm=TRUE))        #그룹별 갯수도 나옴


#%.%    좌측에 데이터를 우측에 함수의 첫번째 인수로 연결
view(pi_tbl2_grp)
pi_tbl2_grp %>% view()


pi_tbl %>%
    select( sex,ends_with("date")) %>%
    mutate_at( .vars=vars(ends_with("date")),
               .funs = list(dt=as.Date)) %>%
    mutate( dur=released_date_dt-confirmed_date_dt) %>%
    group_by(sex) %>%
    summarise(
        n=n(),
        dur_mean=mean(dur,na.rm=TRUE),
        dur_median=median(dur,na.rm=TRUE)
    )
