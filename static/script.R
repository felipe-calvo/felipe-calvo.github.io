# Cargar librerías
library('googlesheets')
library('tidyverse')

# Cargo datos
link = "https://docs.google.com/spreadsheets/d/1SFeDEgFt2_x6JNDdpbvyQ3yHvrLf_bWSoyhJSsdZ1YA/edit?usp=sharing"
gs_url(link, lookup = FALSE, verbose = FALSE) -> online_gs_object
gs_read(online_gs_object, verbose = FALSE) -> data

# Reviso estructura de datos
str(data)

##########################
# REGRESIÓN
##########################

# Tiempo de desplazamiento en funcion de la edad
regresion_1 <- lm(tiempo_desplazamiento ~ edad, data = data)
summary(regresion_1)

# Aporte al fondo común en función del tiempo de desplazamiento
regresion_2 <- lm(fondo_comun_mio ~ tiempo_desplazamiento, data = data)
summary(regresion_2)
# Veamos esa correlación
cor(data$fondo_comun_mio,data$tiempo_desplazamiento)

# Aporte al fondo común en función de la edad
regresion_3 <- lm(fondo_comun_estudiantes ~ edad, data = data)
summary(regresion_3)

##########################
# ANOVA
##########################

# Tiempo de desplazamiento en funcion del sexo
anova_1 <- aov(tiempo_desplazamiento ~ sexo, data = data)
summary(anova_1)

# Aporte al fondo comun en función del sexo
anova_2 <- aov(fondo_comun_mio ~ sexo, data = data)
summary(anova_2)

##########################
# REGRESIÓN LOGÍSTICA
##########################

# Defino variables categoricas
categoricas <- c("iniciativa","cumplir_compromisos","tomar_riesgos","fijar_metas","buscar_info","persuacion","soy_seguro","hablar_publico","reflexiono")
data %>%
  mutate_at(categoricas, factor) -> data_clean

# Reviso nueva estructura de datos
str(data_clean)

# Importancia de reflexionar en función de la edad
logistica_1 <- glm(reflexiono ~ tiempo_desplazamiento, data = data_clean, family = binomial)
summary(logistica_1)

# Importancia de hablar en público en función del tiempo de desplazamiento
logistica_2 <- glm(hablar_publico ~ tiempo_desplazamiento, data = data_clean, family = binomial)
summary(logistica_2)

##########################
# TEST CHI-CUADRADO
##########################

# Soy seguro versus sexo
chi_1 <- chisq.test(table(data_clean$soy_seguro, data_clean$sexo))
chi_1
# Miremos la tabla de contingencia
table(data_clean$soy_seguro, data_clean$sexo)

# Soy seguro versus sexo
chi_2 <- chisq.test(table(data_clean$tomar_riesgos, data_clean$sexo))
chi_2
# Miremos la tabla de contingencia
table(data_clean$tomar_riesgos, data_clean$sexo)
