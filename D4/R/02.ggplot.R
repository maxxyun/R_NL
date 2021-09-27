install.packages("showtext")
library(showtext)

font.add(family="KD",
         reqular ="C:\\Windows\Fonts\KoPub Batang Medium.ttf")
showtext_auto()

library(tidyverse)

ggplot()

ggplot(data=a_data)+
    geom_histogram(aes(x=duration))

ggplot(data=a_data)+
    geom_histogram(aes(x=duration,
                       fill=cntr_name))     #나라에 따라 색을 채우기

ggplot(data=a_data)+
    geom_bar(aes(x=cntr_name,
                 fill=age_cat))

ggplot(data=a_data)+
    geom_bar(aes(x=cntr_name,
                 fill=age_cat),
             position="dodge")

ggplot(data=a_data)+
    geom_bar(aes(x=cntr_name,
                 fill=age_cat),
             position="dodge")+
    labs(x="국가별",y="참여자 수", fill="연령대")

ggplot(data=a_data)+
    geom_bar(aes(x=cntr_name,
                 fill=age_cat),
             position="dodge")+
    labs(x="국가별",y="참여자 수", fill="연령대")+
    theme(
        text=element_text(family = "KD"),
        legend.title = element_text(family="KD",
                                    size=10)
    )


#테마 패키지 설치
install.packages("ggthemes")
library(ggthemes)

ggplot(data=a_data)+
    geom_bar(aes(x=cntr_name,
                 fill=age_cat),
             position="dodge")+
    labs(x="국가별",y="참여자 수", fill="연령대")+
    theme_wsj()+
    theme(
        text=element_text(family = "KD")
    )

ggplot(data=a_data)+
    geom_bar(aes(x=cntr_name,
                 fill=age_cat),
             position="dodge")+
    labs(x="국가별",y="참여자 수", fill="연령대")+
    theme_fivethirtyeight()+
    theme(
        text=element_text(family = "KD")
    )

ggplot(data=a_data)+
    geom_boxplot(aes(x=cntr_name,y=duration))+
    facet_wrap(vars(age_cat), ncol = 2)

ggsave("./D4/output/boxplot.jpg",
       device = "jpg",
       width=5,height =10,
       units = "cm")
