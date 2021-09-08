# data source 
# https://www.kaggle.com/kimjihoo/coronavirusdataset/version/86?select=PatientInfo.csv

pi <- read.csv("./data/PatientInfo.csv")

pi
as_tibble( pi )

pi_tbl <- as_tibble( pi )
class( pi_tbl )


# dplyr

# filter
filter( pi_tbl, state == "released" )

filter( pi_tbl, state == "released" &
                province == "Seoul" )

# select

select( pi_tbl, patient_id, sex, age, city )

select( pi_tbl, ends_with("date") )



# mutate

mutate( pi_tbl, sex_age=paste(sex, age, sep="_") )

transmute( pi_tbl, sex_age=paste(sex, age, sep="_") )

mutate_at( pi_tbl, .vars = vars( ends_with("date") ), .funs = list(dt=as.Date) )



# arrange

arrange( pi_tbl, province )

arrange( pi_tbl, desc(province) )

arrange( pi_tbl, desc(province), sex )



# summarise

pi_tbl2 <- mutate_at( pi_tbl, 
                      .vars = vars( ends_with("date") ), 
                      .funs = list(dt=as.Date) )
pi_tbl2 <- mutate( pi_tbl2, 
                   dur = released_date_dt - confirmed_date_dt )

summarise(pi_tbl2, 
          dur_mean = mean(dur, na.rm=TRUE) )

pi_tbl2_grp <- group_by(pi_tbl2, sex)
summarise(pi_tbl2_grp, 
          dur_mean = mean(dur, na.rm=TRUE) )



# 파이프 연산자
pi_tbl %>%
  mutate_at( .vars = vars( ends_with("date") ), 
             .funs = list(dt=as.Date) )


pi_tbl %>%
  mutate_at( .vars = vars( ends_with("date") ), 
             .funs = list(dt=as.Date) ) %>%
  mutate( dur = released_date_dt - confirmed_date_dt ) %>%
  group_by( sex ) %>%
  summarise( dur_mean = mean(dur, na.rm=TRUE) ) %>%
  arrange( desc(dur_mean) )

