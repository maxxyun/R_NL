# 설치한 패키지 업데이트하기
install.packages( installed.packages()[ , 1], repos="https://cran.seoul.go.kr" )

# 이하 https://e-datanews.tistory.com/155 참고

# java 설치
install.packages("multilinguer")
library( multilinguer )
install_jdk()

# 필요한 패키지 설치
install.packages( c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")

# remotes 패키지 설치
install.packages( "remotes" )

# KoNLP 설치
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))


install.packages(c("ggraph", "tidygraph"))

library( tidyverse )
library( readxl )
library( KoNLP )
library( ggraph )
library( tidygraph )

useNIADic()
1
1
