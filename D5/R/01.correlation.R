library( tidyverse )
library( showtext )

font_add(family = "KD", regular = "KoPubWorld Dotum Medium.ttf")
showtext_auto()

a_data <- readRDS("./data/a_data.rds")

# 상호문화 이해와 가족관계의 산점도
ggplot( a_data ) +
  geom_point( aes( B_mean, C_mean) ) +
  labs( x = "상호문화 이해", y = "가족관계") +
  scale_x_continuous(limits=c(1, 4)) +
  theme_minimal() +
  theme(
    text = element_text(family="KD"),
    axis.line = element_line( size=1 ),
    panel.grid.minor = element_blank()
  )


# 상관계수와 상관계수 검정
cor( a_data$B_mean, a_data$C_mean )
cor.test( a_data$B_mean, a_data$C_mean )

