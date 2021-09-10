# 자유도가 5인 t분포에서
# 0보다 작을 확률을 구하자


# d :P(X=x)
dt(0,df=5)

x<-seq(-3,3,by=0.01)
y<-dt(x,df=5)
plot(x,y,type="l")   # type="소문자 L"

# P:p(X <= x), 분포함수
pt(0,df=5)

#p(-2<=t<=0)
pt(0,df=5)-pt(-2,df=5)

# q : p(X<= x) = q(알고 있음)
qt(0.025,df=5)

# 표준정규분포 (norm)
# p(X <= x) = 0.025
qnorm(0.025, mean=0, sd=1)  #-1.96이 어떻게

# r : 난수 생성 ,n
rt(100,df=5)

