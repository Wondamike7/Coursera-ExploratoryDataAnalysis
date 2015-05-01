swirl()
head(airquality)
xyplot(Ozone~Wind, airquality)
xyplot(Ozone~Wind, airquality, col="red", pch=8, main="Big Apple Data")
xyplot(Ozone~Wind | as.factor(Month), airquality, layout=c(5,1))
xyplot(Ozone~Wind | Month, airquality, layout=c(5,1))

p <- xyplot(Ozone~Wind,data=airquality)
names(p) ## 45 elements in the trellis object, many NULL
mynames[myfull]
p[["formula"]]
p[["x.limits"]]
table(f)
xyplot(y~x|f,layout=c(2,1))

myedit("plot1.R")
source(pathtofile("plot1.R"),local=TRUE)
# p <- xyplot(y ~ x | f, panel = function(x, y, ...) {
#   panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
#   panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
# })
# print(p)
# invisible()

myedit("plot2.R")
source(pathtofile("plot2.R"),local=TRUE)
# p2 <- xyplot(y ~ x | f, panel = function(x, y, ...) {
#   panel.xyplot(x, y, ...)  ## First call default panel function
#   panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
# })
# print(p2)
# invisible()


str(diamonds)
table(diamonds$color)
table(diamonds$color,diamonds$cut)

myedit("myLabels.R")
source(pathtofile("myLabels.R"),local=TRUE)
# myxlab <- "Carat"
# myylab <- "Price"
# mymain <- "Diamonds are Sparkly!"

xyplot(price~carat | color*cut, diamonds, strip=FALSE, pch=20, xlab=myxlab, ylab=myylab, main=mymain)
xyplot(price~carat | color*cut, diamonds, pch=20, xlab=myxlab, ylab=myylab, main=mymain) ## showed that strip adds the labels for each panel
savehistory("./swirl6.R")
