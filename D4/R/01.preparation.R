# install.packages("readxl")
library( readxl )

data <- read_excel("./data/ex_data.xlsx")
dim( data )
names( data )

library( tidyverse )

# 연령대 처리
itv <- c(0, 25, 30, 35, 40, Inf)
cut( data$age, itv )

data %>%
  mutate( age_cat = cut( age, itv ) ) %>% View()

data <- data %>%
  mutate( age_cat = cut( age, itv ) ) 

View( data )

levels( data$age_cat )

# 국가변수 범주화
factor( data$country,
        levels = c(1,   2),
        labels = c("A", "B") )

data <- data %>%
  mutate( cntr_name = factor( 
                        country,
                        levels = c(1, 2),
                        labels = c("A", "B") )
          ) # mutate 닫기


# 연령대 이름표 바꾸기
levels(data$age_cat)
factor( data$age_cat,
        levels = levels(data$age_cat),
        labels = c("20대 초반", "20대 후반", 
                   "30대 초반", "30대 후반",
                   "40대 이상")
        )

data <- data %>%
  mutate(
    age_cat = factor( age_cat,
                      levels = levels(age_cat),
                      labels = c("20대 초반", "20대 후반", 
                                 "30대 초반", "30대 후반",
                                 "40대 이상")
    )
  )


# 직업 여부 변경하기 : 각자 해보세요!!!



# 교육정도 이름표 부여하기
data <- data %>%
  mutate( 
    edu.level = factor( edu.level,
                        levels = c(1, 2, 3),
                        labels = c("중졸이하", "고졸", "대졸이상"))
    )

# 소득 이름표 부여하기
data <- data %>%
  mutate( 
    income = factor( income,
                        levels = c(1, 2, 3, 4),
                        labels = c("150만원 이하",
                                   "150~200만원",
                                   "200만원대",
                                   "300만원 이상"))
  )

# saveRDS( data, "./data/data.rds" )


data %>%
  rowwise()

data <- data %>%
  rowwise() %>%
  mutate(
    A_mean =  mean( c_across( starts_with("A_") ) ),
    B_mean =  mean( c_across( starts_with("B_") ) ),
    C_mean =  mean( c_across( starts_with("C_") ) )
  )


# 표준편차는 각자 구해주세요!


names( data )
# 분석 데이터로 다시 만들기
a_data <- data %>%
  select( "no", "age", jobs:income, "age_cat", "cntr_name",
          ends_with("_mean"), ends_with("_sd") )

saveRDS( a_data, "./data/a_data.rds" )

