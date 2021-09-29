library(tidyverse)

# total mean
m <- mean( iris$Sepal.Length )
m
hist( iris$Sepal.Length, probability = TRUE )
abline(v=m, col="red")

# total variation
sum( (m - iris$Sepal.Length)^2 )

iris %>%
  ggplot(aes(Sepal.Length, color=Species)) +
  geom_density()



# groupped
grp1 <- iris$Sepal.Length[iris$Species == "setosa"]
grp2 <- iris$Sepal.Length[iris$Species == "versicolor"]
grp3 <- iris$Sepal.Length[iris$Species == "virginica"]

m1 <- mean( grp1 )
m2 <- mean( grp2 )
m3 <- mean( grp3 )

plot( rep(-1, 150), iris$Sepal.Length, xlim=c(-1, 4), axes=FALSE, xlab="" )
points( rep(1, 50), grp1, col="blue" )
points( rep(2, 50), grp2, col="green" )
points( rep(3, 50), grp3, col="red" )
lines( c(-1, 4), c(m, m), col="black", lty=2)
lines( c(0.8, 1.2), c(m1, m1), col="blue", lwd=2)
lines( c(1.8, 2.2), c(m2, m2), col="green", lwd=2)
lines( c(2.8, 3.2), c(m3, m3), col="red", lwd=2)




# within variation
sum( (m1 - grp1)^2 )
sum( (m2 - grp2)^2 )
sum( (m3 - grp3)^2 )

wv <- sum( (m1 - grp1)^2 ) + sum( (m2 - grp2)^2 ) + sum( (m3 - grp3)^2 )
wv

# between variance
50 * (m1 - m)^2
50 * (m2 - m)^2
50 * (m3 - m)^2


bv <- 50 * (m1 - m)^2 + 50 * (m2 - m)^2 + 50 * (m3 - m)^2
bv
wv + bv

# total variation
sum( (m - iris$Sepal.Length)^2 )

# mse
mse <- (sum( (m1 - grp1)^2 )  + sum( (m2 - grp2)^2 ) + sum( (m3 - grp3)^2 )) / 147
mse

# mst
mst <- bv / 2
mst
mst / mse

result <- aov( iris$Sepal.Length ~ iris$Species )
summary( result )