install.packages( c("tidymodels", "dotwhisker", "broom.mixed"))

library( tidyverse )
library( tidymodels )
library( dotwhisker )
library( broom.mixed )


# 데이터 읽기
urchins_url <- "https://tidymodels.org/start/models/urchins.csv"
read_csv( urchins_url )

# 열 이름 설정하기
read_csv( urchins_url ) %>%
  setNames( c("food_regime", "initial_volume", "width") )

# food_regime을 "Initial", "Low", "High"를 수준으로 갖는
# factor로 변환하기
read_csv( urchins_url ) %>%
  setNames( c("food_regime", "initial_volume", "width") ) %>%
  mutate( food_regime = factor( 
                          food_regime,
                          levels = c("Initial", "Low", "High") ) )

# 변수로 저장하기 
urchins <- read_csv( urchins_url ) %>% 
  setNames( c("food_regime", "initial_volume", "width") ) %>%
  mutate( food_regime = factor( 
                          food_regime,
                          levels = c("Initial", "Low", "High") 
                          ) )

urchins


#### 데이터 살펴보기
ggplot(urchins, aes(x = initial_volume, y = width, 
                    color = food_regime)) + 
  geom_point() + 
  geom_smooth(method = lm, se = FALSE) +
  theme_minimal()


