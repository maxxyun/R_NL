install.packages( c("tidymodels", "skimr", "nycflights13"))

library( tidyverse )
library( tidymodels )
library( nycflights13 )
library( skimr )

# 데이터 준비
flight_data <- flights %>% 
  mutate(
    # 30분 이상 지연될 시 late, 그렇지 않으면 on_time
    arr_delay = ifelse(arr_delay >= 30, "late", "on_time"),
    # factor 변환
    arr_delay = factor(arr_delay),
    # 날짜 데이터로 변환
    date = lubridate::as_date(time_hour)
  ) %>% 
  # flights 데이터셋과 weather 데이터셋 합치기(join)
  # join 조건은 origin 열과 time_hour 열이 같은 행끼리 연결
  inner_join(weather, by = c("origin", "time_hour")) %>% 
  # 분석에 사용할 열 선택
  select(dep_time, flight, origin, dest, air_time, distance, 
         carrier, date, arr_delay, time_hour) %>% 
  # 결측값 제거
  na.omit() %>% 
  # 문자열로 되어 있는 열들을 모두 factor로 변환
  mutate_if(is.character, as.factor)

# 살펴보기
glimpse( flight_data )


# 지연과 비지연의 비율
flight_data %>%
  count( arr_delay )

flight_data %>%
  count( arr_delay ) %>%
  mutate( prop = n / sum(n) )

flight_data %>%
  skim(dest, carrier)



# 데이터 나누기

# 난수의 초기값 : 서로 동일한 난수 생성
set.seed(222)

# 데이터 분리하기, 비율은 훈련 데이터가 75%가 되도록
data_split <- initial_split(flight_data, prop = 3/4)

# 훈련 데이터와 검정 데이터로 나누어 저장하기
train_data <- training(data_split)
test_data  <- testing(data_split)

# tidymodels의 3단계
# recipe -> prep -> bake


# recipe

# role
flights_rec <- recipe(arr_delay ~ ., data = train_data) 
summary( flights_rec )

flights_rec <- recipe(arr_delay ~ ., data = train_data) %>% 
                  update_role(flight, time_hour, new_role = "ID") 
summary( flights_rec )


# features : step_ 계열 함수
# 도착에 영향을 미치는 요소로 요일, 월, 휴일 등을 처리
recipe(arr_delay ~ ., data = train_data) %>% 
  update_role(flight, time_hour, new_role = "ID") %>% 
  step_date(date, features = c("dow", "month")) %>%
  step_holiday(date, 
               holidays = timeDate::listHolidays("US"), 
               keep_original_cols = FALSE)

# 더미변수 처리 : nominal(factor) 데이터는 모두 더미변수 처리
recipe(arr_delay ~ ., data = train_data) %>% 
  update_role(flight, time_hour, new_role = "ID") %>% 
  step_date(date, features = c("dow", "month")) %>%               
  step_holiday(date, 
               holidays = timeDate::listHolidays("US"), 
               keep_original_cols = FALSE) %>% 
  step_dummy(all_nominal_predictors())


# 드물게 나타나는 명목형 변수의 값으로 인해 훈련 데이터에는 없는 더미변수 제거
# anti_join을 이용하여 확인 : test_data에만 있는 값 확인
test_data %>% 
  distinct(dest) %>% 
  anti_join(train_data)

# 위의 테스트 데이터에만 있는 특히 factor의 경우 level에는 존재하지만,
# 데이터로는 존재하지 않는 0의 분산을 갖는 설명변수의 값 관리
flights_rec <- recipe(arr_delay ~ ., data = train_data) %>% 
  update_role(flight, time_hour, new_role = "ID") %>% 
  step_date(date, features = c("dow", "month")) %>%               
  step_holiday(date, 
               holidays = timeDate::listHolidays("US"), 
               keep_original_cols = FALSE) %>% 
  step_dummy(all_nominal_predictors()) %>%
  step_zv( all_predictors() )


# 분석에 사용할 모델 : 로지스틱 회귀모델
lr_mod <- 
  logistic_reg() %>% 
  set_engine("glm")


# recipe 적용하기
flights_wflow <- 
  workflow() %>% 
  add_model(lr_mod) %>% 
  add_recipe(flights_rec)

flights_wflow



# 훈련데이터에 recipe를 적용하고 모델 훈련하기 
flights_fit <- flights_wflow %>% 
                  fit(data = train_data)

flights_fit

# 결과를 모아 봅시다 : 계수 추출하기
flights_fit %>% 
  extract_fit_parsnip() %>% 
  tidy() 

flights_fit %>% 
  extract_fit_parsnip() %>% 
  tidy() %>% as.data.frame()

# recipe 보기
flights_fit %>% 
  extract_recipe() %>% 
  tidy() 



# 검정데이터로 훈련 모델의 예측값 확인하기
predict(flights_fit, test_data)

# 세부내용
predict(flights_fit, test_data, type="prob")

flights_aug <- augment( flights_fit, test_data ) %>%
  select(arr_delay, time_hour, flight, .pred_class, .pred_on_time, .pred_late)

flights_aug



# 성능측정
flights_aug %>%
  roc_curve( truth = arr_delay, .pred_late ) %>%
  autoplot( )

flights_aug %>%
  roc_auc( truth = arr_delay, .pred_late )

