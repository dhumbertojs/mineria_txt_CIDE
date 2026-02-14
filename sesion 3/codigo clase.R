# 28 de enero 2026
# Enrique Garcia Tejeda
# Sesion TRES. Minería de Texto. Escuelas de Métodos 2026

# install.packages("quanteda")
# install.packages("quanteda.textplots")
# install.packages("readtext")
# install.packages("textdata")
# install.packages("dplyr")

library(quanteda)
library(quanteda.textplots)

library(readtext)  #Leer un gran conjunto de archivos de word 
library(textdata)  #Obtener diccionario de sentimientos
library(dplyr)   #Un manejo más sencillo de los datos 

# Flujo de trabajo en Modelos de Minería de Texto
# 1. Cargar un corpus 
# 2. Crear tokens
# 3. Crear un dfm (matriz con características del documento)
# 4. Implementar un modelo de Aprendizaje de Máquina 

# 1. Cargar un corpus 
amigos <- readtext("F:\\2026\\serie\\*.*")
head(amigos)

friends <- corpus(amigos)
summary(friends)
?corpus

# 2. Crear tokens
mi_token <- tokens(friends, remove_punct = TRUE)
mi_token <- tokens_remove(mi_token, stopwords("english"))

kwic(mi_token, "Rachel")
kwic(mi_token, "new")

# 3. Crear objeto llamado DFM
mi_dfm <- dfm(mi_token)
mi_dfm

topfeatures(mi_dfm)

textplot_wordcloud(mi_dfm, min_size = 2, max_size = 6, color = "hotpink2")

# Remover otras palabras con ruido 
mi_token2 <- tokens_remove(mi_token, c("monica", "ross", "rachel",
                                       "chandler", "joey", "phoebe"))
mi_dfm2 <- dfm(mi_token2)
topfeatures(mi_dfm2)

textplot_wordcloud(mi_dfm2, color ="hotpink2")

# SEGUNDA PARTE
# Analisis de sentimiento
setwd("~/2026/episodes")

friends <- read.csv("Friends.csv")

mi_token <- tokens(friends$descripcion, remove_punct = TRUE)
mi_token <- tokens_remove(mi_token, stopwords("english"))

mi_dfm <- dfm(mi_token)
mi_dfm

topfeatures(mi_dfm)

#Diccionario de sentimientos
mi_diccionario <- as.data.frame(lexicon_nrc())

table(mi_diccionario$sentiment)
?lexicon_nrc()

# Construccion de diccionario de sentimientos
anger <- filter(mi_diccionario, sentiment == "anger")
anticipation <- filter(mi_diccionario, sentiment=="anticipation")
disgust <- filter(mi_diccionario, sentiment=="disgust")
fear <- filter(mi_diccionario, sentiment=="fear")
joy <- filter(mi_diccionario, sentiment=="joy")
negative <- filter(mi_diccionario, sentiment=="negative")
positive <- filter(mi_diccionario, sentiment=="positive")
sadness <- filter(mi_diccionario, sentiment=="sadness")
surprise <- filter(mi_diccionario, sentiment=="surprise")
trust <- filter(mi_diccionario, sentiment=="trust")

mi_diccionario2 <- dictionary(list(Enojo = anger$word, 
                                   Expectativa = anticipation$word,
                                   Asco = disgust$word,
                                   Miedo = fear$word,
                                   Alegría = joy$word,
                                   Pesimismo = negative$word,
                                   Optimismo = positive$word,
                                   Tristeza = sadness$word,
                                   Sorpresa = surprise$word,
                                   Confianza = trust$word)) 

resultado <-dfm_lookup(mi_dfm, dictionary = mi_diccionario2)
# Cuantas palabras hay de tristeza, enojo, positivas, etc 

resultado

adp <- convert(resultado, to = "data.frame")

adp$positivo <- adp$Expectativa + adp$Alegría + adp$Optimismo 
+ adp$Sorpresa + adp$Confianza

adp$negativo <- -1*(adp$Enojo+ adp$Asco + adp$Miedo + adp$Pesimismo
                    + adp$Tristeza)

adp$total <- adp$negativo + adp$postivo

serie <- cbind(friends, adp)

barplot(serie$positivo, ylim = c(-20,20), col = "pink", 
        names = paste(serie$temporada,".",serie$numero), 
        las =2, cex.names = 0.5)
barplot(serie$negativo, add = TRUE, col = "aquamarine3", 
        las =2)
