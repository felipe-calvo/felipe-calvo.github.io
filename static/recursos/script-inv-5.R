# Instalar paquetes
install.packages("readxl")
install.packages("fitdistrplus")
install.packages("logspline")

# Cargar paquetes
library("readxl")
library("fitdistrplus")
library("logspline")

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

# Prueba t para muestras no apareadas
# Paramétrica
# Varianzas no iguales
# Test de Welch
t.test(write, read, paired = FALSE, var.equal = FALSE)

# Prueba t para muestras no apareadas
# Paramétrica
# Varianzas iguales 
# Test de Student
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
# Test de Welch
t.test(write, read, paired = TRUE)

# Prueba t para muestras apareadas
# No paramétrica
# Prueba de los rangos con signo de Wilcoxon
wilcox.test(write, read, paired = TRUE)

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

# 
# 3 o más muestras/grupos apareados
# 

# Paramétrica
# ANOVA de una vía con múltiples repeticiones

# No Paramétrica
# Test de Friedman
friedman.test(cbind(read, write, math))

##########################
#
# Probar relaciones entre variables
#
##########################

# 
# Correlación de Pearson
# Para dos variables continuas
# 

cor(read, write)
cor.test(read, write)

# 
# Correlación de Spearman (Correlación no paramétrica)
# Para dos variables continuas
# 

cor.test(write, read, method = "spearman")

# 
# Prueba Chi
# Asociación entre dos variables categórcias
# 
chisq.test(table(female, schtyp))
