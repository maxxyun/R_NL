library( tidyverse )
help (cars)
# 회귀분석
# 단순선형회귀분석

# 그림부터...
plot( data=cars, dist ~ speed )
cor( cars$speed, cars$dist )

# 회귀분석 (선형 모형, Linear model)
model <- lm( dist ~ speed, data = cars )
model           #회귀식 distance = 3.932*speed - 17.579
names( model )  #coefficients:계수, residuals:잔차
coef( model )
# 추세선 그리기
abline( model, col="red", lty = 2 )

summary( model )

# 회귀식에 의한 추정 직선 표현 
ggplot( cars, aes( speed, dist ) ) +
  geom_point(  ) +
  geom_smooth( method="lm", se=FALSE, col="red") +
  labs( x = "Speed(mile per hour)", 
        y = "Distance(ft.)" ) +
  theme_minimal()

# 또 다른 방법
ggplot( cars, aes( speed, dist) ) +
  geom_point(  ) +
  geom_abline( col="red", 
               intercept = coef(model)[1],  
               slope = coef(model)[2]) +
  labs( x = "Speed(mile per hour)", 
        y = "Distance(ft.)" ) +
  theme_minimal()

# 회귀진단
par( mfrow=c(2, 2) )
plot(model)

# 종속변수 변환
model2 <- lm( sqrt(dist) ~ speed, data = cars)
model2
summary( model2 )
par(mfrow=c(1,1))
plot( data = cars, sqrt(dist) ~ speed )
abline( model2, col="red", lty=2 )

# 회귀진단
par( mfrow=c(2,2) )
plot( model2 )

# 영향력이 큰 데이터 확인
cars[c(23, 35, 39) , ]
fivenum(cars$dist)
fivenum(cars$speed)

# 원점을 지나는 회귀
# 속도가 0인데 제동거리가 1.2가 나오면 말이 안됨
# 회위 모형 안에 -1을 붙인다
model3 <- lm( sqrt(dist) ~ speed - 1, data = cars)
summary( model3 )
# 스피드의 최대값가 최소값을 보임
range(cars$speed)

# 회귀분석 결과를 보다 깔끔하게 나타내기
# install.packages("stargazer")
library(stargazer)
stargazer( model2, type="text")
stargazer( model3, type="text")
