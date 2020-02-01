#
# Regresión logística
#

library("ggplot2")
library("cowplot")
library("car")

data <- read.csv("data/binary.csv")
attach(data)
str(data)
data$rank <- factor(data$rank)
summary(data)

xtabs(~admit + rank, data = data)
modelo.simple <- glm(admit ~ rank, data = data, family = "binomial")
summary(modelo.simple)
ll.null <- modelo.simple$null.deviance/-2
ll.proposed <- modelo.simple$deviance/-2
## McFadden's Pseudo R^2 = [ LL(Null) - LL(Proposed) ] / LL(Null)
(ll.null - ll.proposed) / ll.null
# P-valor
1 - pchisq(2*(ll.proposed - ll.null), df=(length(modelo.simple$coefficients)-1))

modelo <- glm(admit ~ gre + gpa + rank, data = data, family = "binomial")
summary(modelo)
ll.null <- modelo$null.deviance/-2
ll.proposed <- modelo$deviance/-2
## McFadden's Pseudo R^2 = [ LL(Null) - LL(Proposed) ] / LL(Null)
(ll.null - ll.proposed) / ll.null
# P-valor
1 - pchisq(2*(ll.proposed - ll.null), df=(length(modelo$coefficients)-1))

vif(modelo)

x <- data.frame(gre=790,gpa=3.8,rank=as.factor(1))
p<- predict(modelo,x)
p
