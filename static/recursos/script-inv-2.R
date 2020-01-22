# Cargar librerias
library("FactoMineR")
library("CMC")

#####################
# DATOS SIMULADOS
#####################

# Cargar datos
Y=NULL
Y<-read.table("data/simulados.txt",head=F)

# Análisis de componentes principales
PCA.test = PCA(Y, ncp=3)
plot.PCA(PCA.test, choix = "ind", title="Mapa de Individuos")
plot.PCA(PCA.test, choix = "var", title="Mapa de Variables")

# Detección de items problemáticos
items.ordenados = order(PCA.test$var$cos2[,1], decreasing =F)
items.ordenados = cbind(items.ordenados, PCA.test$var$cos2[items.ordenados,])
items.ordenados

# Curva de Cronbach-Mesbah
alpha.datos=alpha.curve(Y)
alpha.datos

# Invertimos un item
item.invertido=10
temp=array(ifelse(Y[,c(item.invertido)]==1,0,1))
temp.y=NULL
temp.y=Y
temp.y[,c(item.invertido)]=temp

# Análisis de componentes principales
PCA.test.nuevo = PCA(temp.y, ncp=3)
plot.PCA(PCA.test.nuevo, choix = "ind", title="Mapa de Individuos")
plot.PCA(PCA.test.nuevo, choix = "var", title="Mapa de Variables")

# Curva de Cronbach-Mesbah
alpha.datos=alpha.curve(temp.y)
alpha.datos

#####################
# DATOS REALES
#####################

rm(list=ls())

# Cargar datos
Y=NULL
Y<-read.table("data/reales.txt",head=F)

#Separamos los items de imagen
Y<-Y[,c(96:109)]

#Resumen de los datos
summary(Y)

# Análisis de componentes principales
PCA.test = PCA(Y, ncp=3)
plot.PCA(PCA.test, choix = "ind", title="Mapa de Individuos")
plot.PCA(PCA.test, choix = "var", title="Mapa de Variables")

# Detección de items problemáticos
items.ordenados = order(PCA.test$var$cos2[,1], decreasing =F)
items.ordenados = cbind(items.ordenados, PCA.test$var$cos2[items.ordenados,])
items.ordenados

# Curva de Cronbach-Mesbah
alpha.datos=alpha.curve(Y)
alpha.datos

# Elimino items problemáticos
Y.new <- subset( Y, select = -c(V98,V102) )

PCA.test = PCA(Y.new, ncp=3)
plot.PCA(PCA.test, choix = "ind", title="Mapa de Individuos")
plot.PCA(PCA.test, choix = "var", title="Mapa de Variables")

# Detección de items problemáticos
items.ordenados = order(PCA.test$var$cos2[,1], decreasing =F)
items.ordenados = cbind(items.ordenados, PCA.test$var$cos2[items.ordenados,])
items.ordenados

# Curva de Cronbach-Mesbah
alpha.datos=alpha.curve(Y.new)
alpha.datos
