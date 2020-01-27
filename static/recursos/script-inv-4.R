# Cargue de datos 

hsb2 <- within(read.csv("data/hsb2.csv"), {
  race <- as.factor(race)
  schtyp <- as.factor(schtyp)
  prog <- as.factor(prog)
})

attach(hsb2)

# Prueba T para una muestra
t.test(write, mu = 50)

# Prueba T para una muestra
wilcox.test(write, mu = 50)

# Prueba binomial
prop.test(sum(female), length(female), p = 0.5)

# Prueba Chi
chisq.test(table(race), p = c(10, 10, 10, 70)/100)
