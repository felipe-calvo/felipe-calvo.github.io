# Instalar librerías
install.packages("psych")
install.packages("boot")

# Cargue de paquetes
library("fitdistrplus")
library("logspline")
library("psych")
library("boot")

# Declaro la muestra
muestra <- c(3.21418,
             4.78087,
             10.2425,
             6.55893,
             6.81382,
             6.26984,
             5.87817,
             6.72368,
             6.37863,
             3.12093,
             8.58566,
             5.61394,
             6.74544,
             8.75352,
             4.95805)

n = length(muestra)
n
media = mean(muestra)
media
desviacion = sd(muestra)
desviacion
hist(muestra)
plot(density(muestra))
descdist(muestra, discrete = FALSE)
fit.normal <- fitdist(muestra, "norm")
plot(fit.normal)
shapiro.test(muestra)
error <- qnorm(0.975)*desviacion/sqrt(n)
left <- media-error
right <- media+error
paste0("Intervalor de confianza para la media")
paste0(left, " <= ",media, " <= ", right)

# Una muestra bootstrap
muestra.boot = sample(muestra, 15, replace = TRUE)
muestra.boot
n = length(muestra.boot)
n
media = mean(muestra.boot)
media
desviacion = sd(muestra.boot)
desviacion
hist(muestra.boot)
plot(density(muestra.boot))
error <- qnorm(0.975)*desviacion/sqrt(n)
left <- media-error
right <- media+error
paste0("Intervalor de confianza para la media - Muestra bootstrap")
paste0(left, " <= ",media, " <= ", right)

# Muchas muestras bootstrap
g=boot(muestra,function(x,i) mean(x[i]),R=100)
# Datos generados
g$t
#intervalo de confianza
boot.ci(g,conf=0.95,type="basic")