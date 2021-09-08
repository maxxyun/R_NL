readRDS("./a/rds")

a

# 데이터 타입 확인함수
typeof(a)   #주석입니다.
typeof(str1)

1           #R에서는 기본적으로 double로 처리
1L
typeof(1L)

#as. 계열함수 : (일시)변환
a
typeof(a)
as.integer(a)
typeof(as.integer(a))

as.integer(a)
a_int<-as.integer(a)
typeof(a_int)

lgc<-TRUE
lgc
as.character(lgc)

as.numeric(TRUE)
as.numeric(FALSE)

#is. 계열함수 : 판단
is.double(a)
is.character(a)

