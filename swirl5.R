library(swirl)
swirl()
## Exploratory Data Analysis, Lesson 5
head(airquality)
range(airquality$Ozone, na.rm=TRUE)
hist(airquality$Ozone)
table(airquality$Month)
boxplot(Ozone~Month,airquality)
boxplot(Ozone~Month,airquality, xlab="Month",ylab="Ozone (ppb)",col.axis="blue",col.lab="red")
title(main="Ozone and Wind in New York City")
with(airquality,plot(Wind,Ozone))
title(main="Ozone and Wind in New York City")

length(par())
names(par())
par()$pin
par('fg')
par("pch")
par("lty")

plot(airquality$Wind,airquality$Ozone,type="n")
title(main="Wind and Ozone in NYC")

may <- subset(airquality, Month==5) ## subset to only May
points(may$Wind,may$Ozone,col="blue",pch=17)
notmay <- subset(airquality, Month!=5) ## subset to all but May
points(notmay$Wind, notmay$Ozone,col="red",pch=8)
legend("topright",pch=c(17,8),col=c("blue","red"),legend=c("May","Other Months"))
abline(v=median(airquality$Wind),lty=2,lwd=2) ## add vertical line at median for Wind

par(mfrow=c(1,2))
plot(airquality$Wind, airquality$Ozone,main="Ozone and Wind")
plot(airquality$Wind, airquality$Solar.R,main="Ozone and Solar Radiation")

par(mfrow=c(1,3),mar=c(4,4,2,1),oma=c(0,0,2,0))
plot(airquality$Wind, airquality$Ozone,main="Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone,main="Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone,main="Ozone and Temperature")
mtext("Ozone and Weather in New York City",outer=TRUE) ## added main text outside the three plots
