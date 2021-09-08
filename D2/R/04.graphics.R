# 산점도
plot( cars$speed, cars$dost,
      main = "속도와 제동거리",
      xlab = "속도(mph)", ylab = "제동거리(ft)",
      pch = 1, col = "red" )


plot( cars$speed, cars$dost,
      main = "속도와 제동거리",
      xlab = "속도(mph)", ylab = "제동거리(ft)",
      pch = 1, col = "red",
      axes = FALSE )
axis(1)
axis(2)

# 시계열 자료
Nile

plot( Nile, main="Nile강의 연도별 유량 변화", 
      xlab="연도", ylab="유량")

plot( Nile, main="Nile강의 연도별 유량 변화", 
      type="p", xlab="연도", ylab="유량")


# 막대 그래프와 히스토그램

# 막대 그래프
mpg$cyl
table( mpg$class )
barplot( table( mpg$class ), 
         main="차 종 분포", xlab="차종", ylab="빈도" )

# 히스토그램

hist( mpg$hwy, main="고속 연비", xlab = "연비", ylab="빈도")


cut(mpg$hwy, breaks=seq(10, 50, 8))

hist( mpg$hwy, main="고속 연비", xlab = "연비", ylab="빈도",
      breaks = seq(10, 50, 8))

hist( mpg$hwy, main="고속 연비", xlab = "연비", ylab="비율",
      breaks = seq(10, 50, 8), probability = TRUE)


hist( mpg$hwy, main="고속 연비", xlab = "연비", ylab="비율",
      breaks = seq(10, 50, 8), probability = TRUE, 
      col=c(NA, "lightgrey", NA, NA, NA) )
