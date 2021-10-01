library( tidyverse )
library( readxl )
library( KoNLP )
library( ggraph )
library( tidygraph )

news <- read_excel("./data/news.xlsx")
articles <- news$본문

articles

useNIADic()

# 사전 정리
# stopwords : 분석에서 사용할 단어
swords <- "해서|하면|하지|들이|당시|생각|경우|하게|때문|하기"
atc <- str_replace_all( articles, swords, " ")

# 한글만 사용하기
articles[1:3 ]
atc <- str_replace_all( atc, "[^가-힣 ]", " ")
atc[1:3]

# 명사 추출하기
SimplePos09("태극기가 바람에 펄럭입니다")
extractNoun("태극기가 바람에 펄럭입니다")

atc_nouns <- extractNoun( atc )
str( atc_nouns )

# 리스트로 된 결과를 문자열 벡터로 만들기
n_words <- simplify( atc_nouns )

# 문자열 길이 : str_length()
str_length( n_words )

# 원소 그룹별 갯수 세기
count( tibble( ex = c("a", "b", "a", "e", "b", "b") ), 
       ex)

count( tibble( ex = c("a", "b", "a", "e", "b", "b") ), 
       ex, sort = TRUE)

# 단어가 두 글자 이상인것만 사용
data.frame( word = n_words ) %>%
  filter( str_length( word ) > 1) %>%
  count( word, sort=TRUE )

# 워드클라우드를 위한 패키지 : wordcloud2
library( wordcloud2 )

data.frame( word = n_words ) %>%
  filter( str_length( word ) > 1) %>%
  count( word, sort=TRUE ) %>%
  wordcloud2()


# 인접한 단어쌍 찾기 (bi-gram)
# lead() 함수 : 바로 뒤의 원소
data.frame( word = n_words ) %>%
  filter( str_length( word ) > 1 ) %>%
  mutate( nxt_word = lead(word) )


# 두 단어 합치기
data.frame( word = n_words ) %>%
  filter( str_length( word ) > 1 ) %>%
  mutate( nxt_word = lead(word) ) %>% 
  filter( word != nxt_word ) %>%
  mutate( bi_gram = paste( word, nxt_word, sep='-') ) %>%
  count( bi_gram, sort = TRUE)

# -를 기준으로 분리하고 저장 : separate()
data.frame( word = n_words ) %>%
  filter( str_length( word ) > 1 ) %>%
  mutate( nxt_word = lead(word) ) %>% 
  filter( word != nxt_word ) %>%
  mutate( bi_gram = paste( word, nxt_word, sep="-") ) %>%
  count( bi_gram, sort = TRUE) %>%
  separate( bi_gram, c("word", "nxt_word"), sep="-") -> bi_gram_df

# library( ggraph )
# library( tidygraph )

# 그래프 형태로 표현
bi_gram_df %>%
  head( 20 ) %>%
  as_tbl_graph()

# 그래프 형태 살펴보기
bi_gram_df %>%
  head( 20 ) %>%
  as_tbl_graph() -> grp_1

grp_1 %>% data.frame()
grp_1 %>% activate( edges ) %>% data.frame( )

# 네트워크 도표 작성
bi_gram_df %>%
  head( 20 ) %>%
  as_tbl_graph() %>%
  ggraph( layout = "kk") +
    geom_edge_link() +
    geom_node_point() +
    geom_node_text( aes(label=name))

# 네트워크 도표 작성 : 세부 설정
bi_gram_df %>%
  head( 20 ) %>%
  as_tbl_graph() %>%
  ggraph( layout = "kk") +
  geom_edge_link(
    aes( width = sqrt( n ) ), show.legend = FALSE
  ) +
  geom_node_point( size=20, color="steelblue" ) +
  geom_node_text( aes(label=name), size = 5) +
  theme_void()



library( showtext )
font_add( family="KDW", regular="KoPubWorld Dotum Medium.ttf")
showtext_auto()

bi_gram_df %>%
  head( 20 ) %>%
  as_tbl_graph() %>%
  ggraph( layout = "kk") +
  geom_edge_link(
    aes( width = sqrt( n ) ), show.legend = FALSE
  ) +
  geom_node_point( size=20, color="steelblue" ) +
  geom_node_text( aes(label=name), size = 5) +
  theme_void() +
  theme(
    text = element_text( family = "KWD" )
  )

