# 다중선형회귀분석
library( tidyverse )

cn_jobs <- readRDS("./D5/data/cn_jobs.rds")

table(iris$Species)

# setosa의 데이터 값만 빠지고 칸은 그대로
iris %>%
  filter( Species != "setosa") -> tmp

table(tmp$Species)
class(tmp$species)
levels(tmp$Species)

# setosa열 자체가 사라짐
lgr_data <- iris %>%
  filter( Species != "setosa") %>%
  mutate( Species = factor( Species,
                            levels = c("versicolor", "virginica")))

class(lgr_data$Species)
levels(lgr_data$Species)

lgr_model <- glm( Species ~ Sepal.Length + Sepal.Width +
                            Petal.Length + Petal.Width, 
                  data = lgr_data, 
                  family = "binomial" )
# family가 binomial인게 logistic regression

lgr_model
summary(lgr_model)

fitted(lgr_model)   #확률 p 예측값. 모델 1~50까지는 매우 작음

fitted(lgr_model)<0.5

c(1,3,-2,4) %% 2 ==0
# 1,3,-2,4를 2로 나눈 나머지가 0이면 1, 아니면 0
ifelse(c(1,3,-2,4) %% 2 ==0,1,0)

# 모델에 적합한 값
lgr_data <- lgr_data %>%
  mutate( fit = fitted(lgr_model) ) %>%
  mutate( pred = ifelse( fit < 0.5, "versicolor", "virginica"))

view(lgr_data)

lgr_data %>%
  mutate( GF = ifelse( Species == pred, 1, 0)) %>%
  summarise ( truePred = sum(GF) / n() )    # 정분류율

# 오분류율. 보통은 정분류보다 오분류율을 더 많이 사용한다
lgr_data %>%
  mutate( GF = ifelse( Species == pred, 0, 1)) %>%
  summarise ( missPred = sum(GF) / n() )

# 새로운 데이터를 사용할 경우에는 predict를 사용합니다.
predict(lgr_model, newdata=lgr_data[c(1, 10, 55),], type="response")
