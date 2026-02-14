# 27 de enero 2026
# DHJS
# Sesion 2

#Librerias
library(quanteda)
library(quanteda.textplots)
library(textdata)

# Encontrar y leer archivo
list.files("sesion 2/Base de datos. Analisis de Sentimientos-20260210", pattern = "byl", full.names = T)
bcs <- read.csv("sesion 2/Base de datos. Analisis de Sentimientos-20260210/Better Call Saul.csv")

# Exploracion
names(bcs) # nombres de las columnas del df
head(bcs) # primeros cinco renglones del df
View(bcs) # ver el df completo

ncol(bcs)
nrow(bcs)
# el df tiene 6 columnas, o variables, y 63 renglones u observaciones.
# las columnas son: temporada, numero, titulo, fecha_estreno, puntuacion, descripcion

boxplot(bcs$puntuacion ~ bcs$temporada)

## Palabras clave y frecuencia
# tokenizacion
token <- tokens(bcs$descripcion)
kwic(token, "Saul")
kwic(token, "Mike")

# Martriz de caracteristicas de documentos (dfm)
bcs_dfm <- dfm(token)
topfeatures(bcs_dfm) # jimmy, mike and kim

## Limpieza y nubes de palabras

# limpieza
token <- tokens(bcs$descripcion, remove_punct = T)
token <- tokens_remove(token, stopwords("english"))
bcs_dfm <- dfm(token)
topfeatures(bcs_dfm)

# nube de palabras
textplot_wordcloud(bcs_dfm) 
textplot_wordcloud(bcs_dfm, min_size = 3, max_size = 10)
# No aparecen emociones o sentimientos, las palabras/features mas frecuentes son nombres de los personajes

# Visualizacion 2 (Grafico de dispersion lexica)
textplot_xray(kwic(token, pattern ="mike")) # Mike no aparece desde el principio de la serie

# Analisis de sentimientos con diccionarios NRC

dx <- as.data.frame(lexicon_nrc())

# Construccion de diccionario de sentimientos
anger <- filter(dx, sentiment == "anger")
anticipation <- filter(dx, sentiment=="anticipation")
disgust <- filter(dx, sentiment=="disgust")
fear <- filter(dx, sentiment=="fear")
joy <- filter(dx, sentiment=="joy")
negative <- filter(dx, sentiment=="negative")
positive <- filter(dx, sentiment=="positive")
sadness <- filter(dx, sentiment=="sadness")
surprise <- filter(dx, sentiment=="surprise")
trust <- filter(dx, sentiment=="trust")

dx2 <- dictionary(list(Enojo = anger$word, 
                                   Expectativa = anticipation$word,
                                   Asco = disgust$word,
                                   Miedo = fear$word,
                                   Alegría = joy$word,
                                   Pesimismo = negative$word,
                                   Optimismo = positive$word,
                                   Tristeza = sadness$word,
                                   Sorpresa = surprise$word,
                                   Confianza = trust$word)) 

resultado <- dfm_lookup(bcs_dfm, dictionary = dx2)

adp <- convert(resultado, to = "data.frame")

adp$positivo <- adp$Expectativa + adp$Alegría + adp$Optimismo 
+ adp$Sorpresa + adp$Confianza

adp$negativo <- -1*(adp$Enojo+ adp$Asco + adp$Miedo + adp$Pesimismo
                    + adp$Tristeza)

adp$total <- adp$negativo + adp$positivo

serie <- cbind(bcs, adp)

barplot(serie$positivo, ylim = c(-20,20), col = "pink", 
        names = paste(serie$temporada,".",serie$numero), 
        las =2, cex.names = 0.5)
barplot(serie$negativo, add = TRUE, col = "aquamarine3", 
        las =2)
