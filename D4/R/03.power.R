install.packages( "pwr" )
library( pwr )


# t검정
pwr.t.test( d = 0.5, power = 0.8, sig.level = 0.05,
            type = "two.sample",
            alternative = "two.sided")


pwr.t.test( d = 0.5, n = 115, sig.level = 0.05,
            type = "two.sample",            
            alternative = "two.sided")


# chisq 검정
# 전체 표본수 결정
pwr.chisq.test( w = 0.3, power = 0.8, sig.level = 0.05,
                df = 4)

pwr.chisq.test( w = 0.3, sig.level = 0.05,
                N = 244,›
                df = 4)

