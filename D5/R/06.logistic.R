# 다중선형회귀분석
library( tidyverse )

cn_jobs <- readRDS("./data/cn_jobs.rds")


lgr_data <- iris %>%
  filter( Species != "setosa") %>%
  mutate( Species = factor( Species,
                            levels = c("versicolor", "virginica")))

lgr_model <- glm( Species ~ Sepal.Length + Sepal.Width +
                            Petal.Length + Petal.Width, 
                  data = lgr_data, 
                  family = "binomial" )

lgr_model

# 모델에 적합한 값
lgr_data <- lgr_data %>%
  mutate( fit = fitted(lgr_model) ) %>%
  mutate( pred = ifelse( fit < 0.5, "versicolor", "virginica"))


lgr_data %>%
  mutate( GF = ifelse( Species == pred, 1, 0)) %>%
  summarise ( truePred = sum(GF) / n() )

# 새로운 데이터를 사용할 경우에는 predict를 사용합니다.
predict(lgr_model, newdata=lgr_data[c(1, 10, 55),], type="response")
