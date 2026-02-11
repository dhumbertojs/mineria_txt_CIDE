# 26 de enero de 2026
# Enrique García Tejeda
# Sesión UNO de Minería de Texto


# Primera lección: Estructura de datos parra Minería de Texto

# Variables
saludo <- "Hola mundo"
numero <- 7

# Vectores
nombres <- c("Irékani", "Jorge K.", "Oscar", "Mar", "Natalia", "Lidana")
hermanos <- c(2, 2, 1, 1, 1, 0)

#data frames / marcos de datos

curso <- data.frame(nombres, hermanos)

# Rescatar la información de grupo (nombres y hermanos)

paste(nombres[3], "tiene", hermanos[3], "hermano")

# Escribir el número de hermanos de Jorge K.

paste(nombres[2], "tiene", hermanos[2], "hermanos")

# Segunda lección: Control de flujo de datos
# Bucles (loops), decisión (IF)

i <- 0 # Contador

for(i in 1:6){
  
  print(paste(nombres[i], "tiene", hermanos[i], "hermanos"))
  
}

# Las sigueintes líneas de código escriben que una personas es
# hija único si no tiene hermanos. Hay que utilizar una estructura de
# decisión más una estructrura de bucle

j <- 0

for(j in 1:6){
  
  if(hermanos[j] > 0){
    
    print(paste(nombres[j], "tiene", hermanos[j], "hermanos"))
    
  } else
    
    print(paste(nombres[j], "no tiene hermanos"))
  
}