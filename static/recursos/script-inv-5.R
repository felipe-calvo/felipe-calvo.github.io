# Instalar paquetes
install.packages("readxl")
install.packages("fitdistrplus")
install.packages("logspline")
install.packages("car")
install.packages("nortest")
install.packages("TeachingDemos")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("esquisse")

# Cargar paquetes
library("readxl")
library("fitdistrplus")
library("logspline")
library("car")
library("nortest")
library("TeachingDemos")
library("tidyverse")
library("ggplot2")
library("esquisse")

# Cargar datos
data <- read_xlsx("data/data-h.xlsx", sheet="mod")
attach(data)

##########################
## Pruebas de hipótesis ##
##########################

##########################
#
# Probar la forma de la distribución de probabilidad
# Goodness-of-fit test
#
##########################

# Histograma de los datos
hist(edad)

# Gráfica de la densidad de la función
plot(density(edad))

# Posibles distribuciones
descdist(edad, discrete = TRUE)

# Beta ----- beta
# Binomial ----- binom
# Cauchy ----- cauchy
# Chisquare ----- chisq
# Exponential ----- exp
# F ----- f
# Gamma ----- gamma
# Geometric ----- geom
# Hypergeometric ----- hyper
# Logistic ----- logis
# Lognormal ----- lnorm
# Negative Binomial ----- nbinom
# Normal ----- norm
# Poisson ----- pois
# Student t ----- t
# Uniform ----- unif
# Tukey ----- tukey
# Weibull ----- weib
# Wilcoxon ----- wilcox

# Ajustar distribuciones candidatas
fit.normal    <- fitdist(edad, "norm")
fit.poisson   <- fitdist(edad, "pois")
fit.negbinom  <- fitdist(edad, "nbinom")

# Graficar distribuciones candidatas
plot(fit.normal)
plot(fit.poisson)
plot(fit.negbinom)

# Comparación del criterio AIC
fit.normal$aic
fit.poisson$aic
fit.negbinom$aic

# 
# Caso especial: pruebas de normalidad
# 

# Test de Shapiro-Wilk
# ideal para n < 50, útil hasta n < 2000
shapiro.test(edad)

# Test de Anderson-Darling
# Para muestras grandes
ad.test(edad)

# Test de Snow - datos exactamente normales
SnowsPenultimateNormalityTest(edad)

# Gráfica qq
qqPlot(edad)

##########################
#
# Probar diferencias entre grupos o muestras
#
##########################

detach(data)
data <- read_xlsx("data/data-h.xlsx", sheet="hsb2")
attach(data)
race <- as.factor(race)
schtyp <- as.factor(schtyp)
prog <- as.factor(prog)

# 
# 2 muestras/grupos no apareados 
# 

# Comprobar supuesto de varianzas homogéneas
# Si son homogéneas:      homocedasticidad
# Si no son homogéneas:   héterocedasticidad
# bartlett.test(formula)
# bartlett.test(variableNumerica ~ variable categórica)
# leveneTest(formula)
# leveneTest(variableNumerica ~ variable categórica)

# Prueba t para muestras no apareadas
# Paramétrica
# Varianzas no iguales
# Test de Welch
t.test(write, read, paired = FALSE, var.equal = FALSE)

# Prueba t para muestras no apareadas
# Paramétrica
# Varianzas iguales 
# Test t-Student
t.test(write, read, paired = FALSE, var.equal = TRUE)

# Prueba t para muestras no apareadas
# No paramétrica
# Prueba U de Mann-Whitney
wilcox.test(write, read, paired = FALSE)

# 
# 2 muestras/grupos apareados 
# 

# Prueba t para muestras apareadas
# Paramétrica
# Test t
t.test(write, read, paired = TRUE)

# Prueba t para muestras apareadas
# No paramétrica
# Prueba de los rangos con signo de Wilcoxon
wilcox.test(write, science, paired = TRUE)

# 
# 3 o más muestras/grupos no apareados
# 

# Paramétrica
# Varianzas no iguales
# Test de Kruskall-Wallis
kruskal.test(write, prog)

# Paramétrica
# Varianzas iguales
# ANOVA de una vía
summary(aov(write ~ prog))

# No Paramétrica
# Test de Kruskall-Wallis
kruskal.test(write, prog)

# Si el p-valor < 0.05 es necesario hacer un análisis post-hoc

# 
# 3 o más muestras/grupos apareados
# 

# Paramétrica
# ANOVA de una vía con múltiples repeticiones

# No Paramétrica
# Test de Friedman
friedman.test(cbind(read, write, math))

# Si el p-valor < 0.05 es necesario hacer un análisis post-hoc

# 
# Ejemplo
# ANOVA de una via
# 

detach(data)
data <- read_xlsx("data/data-h.xlsx", sheet="anova")
attach(data)
str(data)

# Convierto columnas necesarias a factores
factores <- c("Cemento")
data %>% mutate_at(factores,factor) -> data
str(data)

# Estadísticos descriptivos
descriptive_stats <- group_by(data, Cemento) %>%
  summarise(
    count = n(),
    mean = mean(MPA, na.rm = TRUE),
    sd = sd(MPA, na.rm = TRUE)
  )
descriptive_stats

#Gráficas
esquisser(data = data, viewer = "browser")

# Bloxplot para cada grupo
ggplot(data = data) +
  aes(x = Cemento, y = MPA) +
  geom_boxplot(fill = "#0c4c8a") +
  theme_minimal()

# Ajustamos modelo ANOVA
res.aov <- aov(MPA ~ Cemento, data = data)
summary(res.aov)

# Comprobación de Supuestos
# Homocedasticidad: Varianza homogénea entre grupos
leveneTest(MPA ~ Cemento, data = data)
# Residuales distribuidos normalmente
aov_residuals <- residuals(object = res.aov)
# Plot residuales
plot(res.aov, 1)
shapiro.test(x = aov_residuals)
# Plot Q-Q
qqPlot(res.aov, 2)

# Post hoc
TukeyHSD(res.aov)

##########################
#
# Probar relaciones entre variables
#
##########################

# 
# Correlación de Pearson
# Para dos variables continuas
# 

# Cálculo del Coeficiente
cor(read, write)

# Prueba de hipótesis
# H0: correlación = 0 
# H1: correlación != 0
cor.test(read, write)

# Gráfico de dispersión entre variables
plot(read, write, main="Gráfico de dispersión", pch = 19)
# Agregamos un modelo de regresión lineal
abline(lm(read ~ write), col = "blue")

# Gráfico de dispersión entre variables
plot(read, write, main="Gráfico de dispersión", pch = 19)
# Agregamos un modelo de regresión local no paramétrica
lines(lowess(read, write), col = "blue")

# 
# Correlación de Spearman (Correlación no paramétrica)
# Para dos variables continuas
# 

# Prueba de hipótesis
# H0: correlación = 0 
# H1: correlación != 0
cor.test(write, read, method = "spearman")

# 
# Prueba Chi
# Asociación entre dos variables categóricas
# 
chisq.test(table(female, schtyp))

##########################
#
# Probar diferencias entre variables
#
##########################

# Comparar medias para dos variables
t.test(write, read, paired = TRUE)
wilcox.test(write, science, paired = TRUE)

# Comparación general no paramétrica de dos variables
## Agresti (1990), p. 350.
Performance <-
  matrix(c(794, 86, 150, 570),
         nrow = 2,
         dimnames = list("Encuesta 1" = c("Aprueban", "Desaprueban"),
                         "Encuesta 2" = c("Aprueban", "Desaprueban")))
Performance
mcnemar.test(Performance)