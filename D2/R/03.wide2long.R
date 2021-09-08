library( tidyverse )

water <- read.csv("./data/water_2020.csv", header=TRUE, check.names = FALSE)
water

water %>%
  pivot_longer( cols = 2:13 )


water %>%
  pivot_longer( cols = 2:13, values_drop_na=TRUE )