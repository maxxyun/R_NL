# 다중선형회귀분석
library( tidyverse )

cn_jobs <- readRDS("./D5/data/cn_jobs.rds")

# 변수간 상관 파악
cn_jobs %>%
  select( education, income, women, prestige) %>%
  cor()

cn_jobs %>%
  select( education, income, women, prestige) %>%
  plot()


# 다중선형회귀분석
# 모델수립
model <- lm( income ~ education + women + prestige,
             data = cn_jobs )

summary( model )


# 변수선택 : AIC
m_s <- step( model, direction = "both" )
formula( m_s )

# 전체 모형 비교
# install.packages("leaps")
library( leaps )
m_rs <- regsubsets(
                    income ~ education + women + prestige,
                    data = cn_jobs )
summary( m_rs )
summary( m_rs )$bic     #두번째가 -90으로 가장 작다
                        #women, prestige만으로 그리자

#표로 쉽게 표기
plot( m_rs, scale="bic" )


# 최종모델과 예측
s_model <- lm( income ~ women + prestige, data = cn_jobs )
summary( s_model )

cn_jobs[c(1, 10), ]
predict( s_model,  cn_jobs[c(1, 10), ])

par( mfrow=c(2, 2) )
plot(s_model)
