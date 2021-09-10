# 독립표본 t검정
data <- read.csv("./data/indep_t_test.csv")

var.test( data$weight ~ data$gender )

t.test( data$weight ~ data$gender,
        mu = 0,
        alternative = "less",
        var.equal = TRUE )


# 대응표본 t검정
paired <- read.csv("./data/anorexia.csv")

t.test( paired$Prior, paired$Post, 
        paired = TRUE,
        alternative = "less" )



# 적합도 검정

qchisq(0.95, df=3)
1 - pchisq(0.470024, df=3)

x <- c(315, 101, 108, 32)
chisq.test(x, p=c(9, 3, 3, 1)/16)




