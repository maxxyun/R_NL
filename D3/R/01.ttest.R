# 변수입력
height <- c(1205, 1194, 1200, 1221,1228,1167,1144,1288,1242,1171,1157,1248,1203,1230,1208)

length(height)          #변수 갯수
mean(height)            #평균
sd(height)              #표준편차
sd(height)/sqrt(length(height))         #표준오차


# 영가설 : 키의 평균은 1220mm
# 대안가설 : 키의 평균은 1220mm가 아니다
# 유의수준 : alpha = 0.05
# 일표본 t검정
help(t.test)
t.test(height,
       mu=1220,
       alternative = "two.sided")


# 대안가설 : 키의 평균은 1220mm < mu
t.test(height,
       mu=1220,
       alternative = "greater")

# 유의수준 : 0.01
# 신뢰구간 : 99%
t.test(height,
       mu=1220,
       alternative = "greater",
       conf.level = 0.99)
