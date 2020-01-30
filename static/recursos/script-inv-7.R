# Instalar paquetes
install.packages("e1071")

# Cargar paquetes
library("readxl")
library("ggplot2")
library("e1071")

# Cargar datos
data <- read_xlsx("data/data.xlsx", sheet="cafeina-1")
attach(data)

#
# Análisis gráfico
#

# Gráfica de dispersión
ggplot(data, aes(x=`Caffeine Content`, y=`Extraction time`)) + geom_point()

# Gráfica de dispersión con línea de regresión
ggplot(data, aes(x=`Caffeine Content`, y=`Extraction time`)) + 
  geom_point() +
  geom_smooth(method=lm, se=FALSE)

# Gráfica de dispersión con un intervalo de confianza para la pendiente
ggplot(data, aes(x=`Caffeine Content`, y=`Extraction time`)) + 
  geom_point() +
  geom_smooth(method=lm, se=TRUE)

# Gráfica de dispersión con regresión local
ggplot(data, aes(x=`Caffeine Content`, y=`Extraction time`)) + 
  geom_point() +
  geom_smooth()

# Boxplot
par(mfrow=c(1, 2))
# box plot para `Caffeine Content`
boxplot(`Caffeine Content`, 
        main="Contenido de cafeína", 
        sub=paste("Outliers: ", boxplot.stats(`Caffeine Content`)$out))
# box plot para `Extraction time`
boxplot(`Extraction time`, 
        main="Tiempo de extracción", 
        sub=paste("Outliers: ", boxplot.stats(`Extraction time`)$out))  

# Gráfico de densidad
# para `Caffeine Content`
plot(density(`Caffeine Content`), 
     main="Gráfico de densidad: Contenido de cafeína", 
     ylab="Frecuencia", 
     sub=paste("Asimetría:", round(e1071::skewness(`Caffeine Content`), 2))) 
polygon(density(`Caffeine Content`), col="red")
# para `Extraction time`
plot(density(`Extraction time`), 
     main="Gráfico de densidad: Tiempo de extracción", 
     ylab="Frecuencia", 
     sub=paste("Asimetría:", round(e1071::skewness(`Extraction time`), 2)))
polygon(density(`Extraction time`), col="red")

#
# Correlación
#

cor(`Caffeine Content`, `Extraction time`)

#
# Ajuste del modelo
#

modelo.lineal <- lm(`Caffeine Content` ~ `Extraction time`, data=data)
print(modelo.lineal)

#
# Validación del modelo
#

summary(modelo.lineal)

# Mirar p-valor
# Mirar R2 (cuando solo hay una variable independiente)
# Mirar R2-ajustado (cuando hay más de una variable independiente)
# R2 entre más alto mejor; aceptable >0.7

# AIC
AIC(modelo.lineal)
# BIC
BIC(modelo.lineal)

# Validación predictiva
set.seed(100) 
# Selección de índices para fragmentar la base de datos 
# basado en una muestra alaetoria
indices.entrenamiento <- sample(1:nrow(data), 0.8*nrow(data))
# Datos de entrenamiento
data.entrenamiento <- data[indices.entrenamiento, ]
# Datos de prueba
data.prueba  <- data[-indices.entrenamiento, ]   

# Construir el modelo
modelo.lineal.pred <- 
  lm(`Caffeine Content` ~ `Extraction time`, data=data.entrenamiento)
# Predecir las distancias
distancias.pred <- predict(modelo.lineal.pred, data.prueba)

# Resumen del modelo ajustado
summary(modelo.lineal.pred)
AIC(modelo.lineal.pred)

# Precisión de la predicción
dist.verdaderas <- 
  data.frame(cbind(actuals=data.prueba$`Caffeine Content`, 
                   predicteds=distancias.pred))
precision <- cor(dist.verdaderas)
precision
head(dist.verdaderas)
