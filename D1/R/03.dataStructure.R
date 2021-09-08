#벡터
v1 <- c(1,3,-2,4)
v1
v2 <- 3:34
v2
v3 <- seq(0,1,0.01)
v3
v4 <- rep(v1,times=2)
v4
v4_2 <- rep(v1,each=2)
v4_2
v5 <- c("a","a","b","c")
v5

v1
v2
v6 <- c(v1,v2)
v6

v1
v5
v7 <- c(v1,v5)
v7

sort(v1)    #정렬
order(v1)   #위치치

rev(v1)     #뒤집기

table(v1)   #값의 빈도표

length(v1)  #값의 갯수

v1
v1+3
v4
length(v4)
v4+v1

v1+(1:3)


gender <-c(1,2,2,2,1)
gender
gender.f <- factor(gender,levels = c(1,2),
                   labels = c("F","M"))
gender.f
table(gender.f)


v1 #col1
v5 #col2

df1 <- data.frame(col1=v1, col2=v5)
df1

dim(df1)    #행과 열의 수를 확인
dim(df1)[1]
nrow(df1)   #행의 수를 확인
ncol(df1)   #열의 수를 확인
names(df1)  #열의 이름 확인

str(df1)    #데이터 구조를 확인
head(df1)   #데이터의 앞 일부를 확인
head(df1, n=2)
tail(df1, n=2)  #데이터의 뒤 일부를 확인


df1
df2 <- df1
df1
df2

rbind(df1, df2)     #row(행)로 합침
cbind(df1, df2)     #column(열)로 합침

dim(df1)
dim(df1)[1]
dim(df1)[2]

v4
v4[3]
v4[-3]              #3번째 값 빼고
1:3
v4[1:3]
v4[c(1,3,length(v4))]   #1, 3번째와 마지막


4%/%3   #몫
4%%3    #나머지

v4
v4%%2

v4%%2 == 0
v4[v4%%2 == 0]  #TRUE만 가져옴

df1
df1[df1$col2 == "a"]
