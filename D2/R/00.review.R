v1 <- c(1,3,-2,4)
v5 <- c("a","a","b","c")

table (v5)
str (table(v5))
length(v5)

v1[3]
1:3
v1[1:3]
v1[length(v5)]
v1[1]

v1[c(1,length(v1))]

v1[1:(length(v1)-1)]
v1[-1]

v1
v1[-1]-v1[1:(length(v1)-1)]



#대괄호 안에 조건식
v1 %% 2     # %% = 나머지
v1
v1 %% 2 == 0
v1[v1%%2==0]

which(v1%%2==0)     #which = TRUE 위치의 값
v1[which(v1%%2==0)]

"abc"       #문자 데이터는 초록색, 숫자는 파랑색
123
