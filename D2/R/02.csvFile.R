read.csv(file="./D2/data/popMove.csv")

pop_move<-read.csv(file="./D2/data/popMove.csv")

#맥의 경우 UTF-8로 기본으로 읽기 때문에 마소의 기본인 euc-kr로 읽으라고 따로 설정해야 함.
#pop_move<-read.csv(file="./D2/data/popMove.csv",fileEncoding="euc-kr")

head(pop_move)
tail(pop_move)
str(pop_move)

pop_move<-read.csv(file="./D2/data/popMove.csv",
                   skip=1,
                   header = TRUE,
                   fileEncoding="euc-kr")

str(pop_move)


pm<-read.csv(file="./D2/data/popMove.csv",
             skip=2,
             header = FALSE,
             fileEncoding="euc-kr")         #헤더 없이 기본값으로 넣어줌

str(pm)


names(pop_move)
names(pop_move)[3]

names(pop_move)<-c("sigungu","input","output","move")     #열 이름을 바꾸기
names(pop_move)

names(pop_move)[1:2]
names(pop_move)[1:2]<-c("col1","col2")      #1번과 2번 열만 이름 바꾸기
names(pop_move)

write.csv(pop_move,file = "./D2/output/popMove.csv",
          row.names = FALSE
         )                              #열에 숫자가 들어가는데 끔.
