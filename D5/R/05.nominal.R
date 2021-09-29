library( tidyverse )

cn_jobs <- readRDS("./data/cn_jobs.rds")

str( cn_jobs )

# 명목형 자료가 있는 다중선형회귀분석
# 모델수립
levels( cn_jobs$type )

model <- lm( income ~ education + women + prestige + type,
             data = cn_jobs )
