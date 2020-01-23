# MAS y MASCR - Selección

sample(1:10,5)
sample(1:10,5)
sample(1:10)
sample(1:10,5,replace=T)
sample(c(0,1),100,replace=T)

# Data frames - Selección

datos=data.frame(x=1:12,estrato=gl(3,4))
attach(datos)
prob=x/78
set.seed(100)
sample(x,replace=T,size=10,prob)
set.seed(100)
muestra=sample(x,replace=T,size=10,prob)
muestrafin=datos[muestra,]

# Tamaño de Muestra

library(samplingbook)
sample.size.mean(e=4,S=10,N=300)
sample.size.mean(e=1,S=10,N=300)
sample.size.prop(e=0.01,P=0.5,N=Inf) # NOTA:con reemplazo
sample.size.prop(e=0.01,P=0.5,N=300)
sample.size.prop(e=0.05,P=0.5,N=300)
sample.size.prop(e=0.05,P=0.5,N=4000000, level = 0.95)
sample.size.prop(e=0.05,P=0.5,N=4000000, level = 0.90)
