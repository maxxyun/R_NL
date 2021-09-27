library( tidyverse )

a_data <- readRDS( "./data/a_data.rds" )

ggplot( a_data ) +
  geom_histogram( aes( x = duration, fill = cntr_name ) )

ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
                  position = "dodge" )


# 한글 처리
install.packages( "showtext" )
library( showtext )
font_add( family = "KD", regular = "KoPubWorld Dotum Medium.ttf")
showtext_auto()


ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  theme(
    text = element_text( family = "KD" )
  )


# 제목 붙히기
ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  labs( x="국가", y="참여자수", fill="연령대") +
  theme(
    text = element_text( family = "KD" )
  )

# 테마변경하기
ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  labs( x="국가", y="참여자수", fill="연령대") +
  theme_bw() +
  theme(
    text = element_text( family = "KD" )
  )


# ggthemes 패키지
install.packages( "ggthemes" )
library( ggthemes )

# Wall Street Journal
ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  labs( x="국가", y="참여자수", fill="연령대") +
  theme_wsj() +
  theme(
    text = element_text( family = "KD" ),
    legend.title = element_text( family = "KD", size=15 )
  )


# tufte
ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  labs( x="국가", y="참여자수", fill="연령대") +
  theme_tufte() +
  theme(
    text = element_text( family = "KD" )
  )

# fivethirtyeight
ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  labs( x="국가", y="참여자수", fill="연령대") +
  theme_fivethirtyeight() +
  theme(
    text = element_text( family = "KD" )
  )


# 범례 위치 바꾸기
ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  labs( x="국가", y="참여자수", fill="연령대") +
  theme_bw() +
  theme(
    text = element_text( family = "KD" ),
    legend.position = "bottom"
  )


# 도표 저장하기
ggsave ( "./output/myPlot.png",
         device = "png",
         width = 16, height = 8,
         units = "cm")


# 도표 분할하기
ggplot( a_data ) +
  geom_bar( aes( x = cntr_name, fill = age_cat ),
            position = "dodge" ) +
  facet_wrap( vars(age_cat) )
