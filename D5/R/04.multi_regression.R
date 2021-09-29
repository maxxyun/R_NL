# 다중선형회귀분석
library( tidyverse )

cn_jobs <- readRDS("./data/cn_jobs.rds")

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
m_rs <- regsubsets( income ~ education + women + prestige, 
                    data = cn_jobs )
summary( m_rs )
summary( m_rs )$bic

plot( m_rs, scale="bic" )


# 최종모델과 예측
s_model <- lm( income ~ women + prestige, data = cn_jobs )
summary( s_model )

cn_jobs[c(1, 10), ]
predict( s_model,  cn_jobs[c(1, 10), ])

par( mfrow=c(2, 2) )
plot(s_model)
