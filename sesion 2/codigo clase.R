# 26 de enero de 2026
# Enrique Garcia Tejeda
# Sesion DOS. Mineria de Texto en R

# 0. Introduccion a las funciones
nombres <- c("Irékani", "Jorge K.", "Oscar", "Mar", "Natalia", "Lidana")
hermanos <- c(2, 2, 1, 1, 1, 0)

# Bucle de impresion en una funcion

todos <-function(x,y,numero){
  
  i <- 0 # Contador
  
  for(i in 1:numero){
    
    print(paste(x[i], "tiene", y[i], "hermanos"))
    
  }
  
}

todos(nombres, hermanos, 6)
todos(nombres, hermanos, 3)

todos(nombres, hermanos, 1)

# 1. Instalacion paqueterias (código con un gran número funciones)
install.packages("beepr")
library(beepr)

beep(8)
beep(5)
beep(7)

?beep

# Instalar librerias para la Mineria de Texto
install.packages("quanteda")
install.packages("quanteda.textplots")

library(quanteda)
library(quanteda.textplots)

# 1. Base datos (friends)
setwd("C:/Users/enriq/Documents/2026/Escuela de Metodos 2026 DAP CIDE/DOS/episodes")

friends <- read.csv("Friends.csv")


# Explorar base de datos
head(friends)
View(friends)    # Funcion de CUIDADO!!!! Tiene una "V" mayuscula

# Visualización base de datos 
boxplot(friends$puntuacion ~ friends$temporada)

# Segunda parte de la sección DOS

# Tokens (puede ser una palabra, una coma, un emoji)

mi_token <- tokens(friends$descripcion)
kwic(mi_token, "Rachel")
kwic(mi_token, "Chandler")

# Matriz de características de los documentos (dfm)

mi_dfm <- dfm(mi_token)
mi_dfm

topfeatures(mi_dfm)

# Eliminar ruido estadistico (puntuacion y stopwords)
mi_token <- tokens(friends$descripcion, remove_punct = TRUE)
mi_token <- tokens_remove(mi_token, stopwords("english"))

mi_dfm <- dfm(mi_token)

topfeatures(mi_dfm)

# Visualización 
textplot_wordcloud(mi_dfm)

textplot_wordcloud(mi_dfm, min_size = 6, max_size = 10, color ="darkblue")

?textplot_wordcloud

# Visualizacion 2 (Grafico de dispersion lexica)
textplot_xray(kwic(mi_token[1:24], pattern ="rachel"))

# Discursos de presidentes de EE.UU.
discursos <- data_corpus_inaugural

dfmat_inaug <- corpus_subset(data_corpus_inaugural, Year > 1949)

dfmat_inaug <- tokens(dfmat_inaug)

textplot_xray(kwic(dfmat_inaug, pattern = "american"))
textplot_xray(kwic(dfmat_inaug, pattern = "people"))

textplot_xray(
  kwic(dfmat_inaug, pattern = "american"),
  kwic(dfmat_inaug, pattern = "war")
)


# Integracion con otras librerias
install.packages("ggplot2")
library("ggplot2")
theme_set(theme_bw())
g <- textplot_xray(
  kwic(dfmat_inaug, pattern = "american"),
  kwic(dfmat_inaug, pattern = "people")
)
g + aes(color = keyword) + 
  scale_color_manual(values = c("blue", "red")) +
  theme(legend.position = "none")