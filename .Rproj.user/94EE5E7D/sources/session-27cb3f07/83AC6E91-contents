# 26 de enro de 2026
# David Humberto Jimenez Sanchez

#construccion de vectores
names <- c("Mariana", "Eider", "Angela", "José", "Sam", "Mauricio", "Javier", 
           "César", "Carolina", "Emiliano")
siblings <- c(1, 2, 0, 3, 4, 2, 2, 1, 4, 0)

#construccion de un dataframe
df <- data.frame(names, siblings)

df[1,] # Muestra el primer nombre y el numero de hermanxs
df[7,] #Muestra el septimo renglon y su correspondiente numero de hermanxs

# 1er modelo: imprime nombres y numeros de hermanos
for(i in 1:10){
  print(paste(df[i, 1], "tiene", df[i, 2], "hermanxs", sep = " "))
}

#2do modelo: imprime nombres y numeros de hermanos, pero distingue si no tiene hermanos
for(i in 1:10){
  if(df[i, 2] > 0){
    print(paste(df[i, 1], "tiene", df[i, 2], "hermanxs", sep = " "))
  }
  else
    print(paste(df[i, 1], "no tiene hermanxs", sep = " "))
}

# crear vector de mascotas
pets <- c(1, 0, 0, 3, 4, 1, 2, 0, 1, 5)

# actualizar data frame
df <- data.frame(names, siblings, pets)

#3er modelo: imprime nombres, hermanxs y mascotas, distingue si no tiene hermanos, o mascotas, ni hermanos ni mascotas
for(i in 1:10){
  if(df[i, 2] > 0 & df[i, 3] > 0){
    print(paste(df[i, 1], "tiene", df[i, 2], "hermanxs", "y", df[i, 3], "mascotas", sep = " "))
  }
  if(df[i, 2] > 0 & df[i, 3] <= 0){
    print(paste(df[i, 1], "tiene", df[i, 2], "hermanxs", "y no tiene mascotas", sep = " "))
  }
  if(df[i, 2] <= 0 & df[i, 3] > 0){
    print(paste(df[i, 1], "no tiene hermanxs", "y tiene", df[i, 3], "mascotas", sep = " "))
  }
  if(df[i, 2] == 0 & df[i, 3] == 0){
    print(paste(df[i, 1], "no tiene hermanxs ni mascotas", sep = " "))}
}
# A mi se me ocurrio hacerlo asipara poder ser especifico sobre los hermanos y mascotas.