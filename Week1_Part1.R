setwd("../Exploratory Data Analysis")
options(digits=4) ## only displays 4 digits

library(utils)
unzip("PM25data.zip")

pollution <- read.csv("data/avgpm25.csv")

dim(pollution)
str(pollution)
head(pollution)
summary(pollution)
summary(pollution$pm25>=12)

pollution <- read.csv("data/avgpm25.csv", colClasses = c("numeric","character","factor","numeric","numeric"))
head(pollution)
summary(pollution$pm25)
plot(pollution$pm25) ## scatterplot
boxplot(pollution$pm25, col="blue") ## boxplot
hist(pollution$pm25, col="green") ## histogram
rug(pollution$pm25) ## rug puts all points underneath histogram; shows bulk of data, plus outliers

hist(pollution$pm25, col="green",breaks=100) ## histogram where you set the number of breaks.
hist(pollution$pm25, col = "green", breaks = 10)
rug(pollution$pm25)

boxplot(pollution$pm25, col = "blue")
abline(h=12) ## adds horizontal line at 12, shows how many are above this

hist(pollution$pm25, col="green")
abline(v=12, lwd=2) ## adds vertical at 12. lwd sets width
abline(v=median(pollution$pm25), col="magenta", lwd=4) ## adds vertical at median

barplot(table(pollution$region),col="wheat",main="Number of Counties in Each Region") 
## the bar plot broke the data down by the categories in the specified table

boxplot(pm25 ~ region, data=pollution, col = "red") ## box plot by region (2 on same chart)
par(mfrow = c(2,1), mar = c(4,4,2,1)) ## sets parameters to allow for two graphs on top of each other. mar changes margins.
hist(subset(pollution, region=="east")$pm25, col="green")
hist(subset(pollution, region=="west")$pm25, col="green")

dev.off() ## closes plot window (and resets parameters?)

## realized that I needed to reset the pars. Online solution to first capture defaults, so you can revert easily.
default.par <- par()
par(mfrow = c(2,1), mar = c(4,4,2,1))
par(default.par) ## when I revert it gives an error that I can't set certain parameters

with(pollution, plot(latitude, pm25))
abline(h=12, lwd=2, lty=2) ## lty set to a dashed line

with(pollution, plot(latitude, pm25, col=region)) ## sets colors by region, black circles are east, red circles are west. 3 Vars on graph now.
abline(h=12, lwd=2, lty=2)

par(mfrow=c(1,2), mar=c(5,4,2,1))
with(subset(pollution,region=="west"), plot(latitude, pm25, main="West"))
with(subset(pollution,region=="east"), plot(latitude, pm25, main="East"))

