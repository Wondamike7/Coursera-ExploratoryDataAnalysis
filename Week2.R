## First portion of week 2 was lattice package
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

## transform month to factor
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(1,5)) ## flipped the rows to columns in the layout

p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)
xyplot(Ozone ~ Wind, data = airquality) ## auto-print vs store and then print; lattice plots to trellis objects

## generate random data set
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f*x + rnorm(100, sd=0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))

xyplot(y ~ x|f, layout = c(2,1)) ## scatter plot of y and x, for each factor f

## custom panel fx 
xyplot(y ~ x|f, panel = function(x, y, ...) {
panel.xyplot(x,y,...) ## first call default panel fx for 'xyplot'
panel.abline(h = median(y), lty=2) ## add horizontal line at y's median
}
)
xyplot(y ~ x|f, panel = function(x, y, ...) {
panel.xyplot(x,y,...) ## first call default panel fx for 'xyplot'
panel.lmline(x,y,col=2) ## add linear regression line
})

## next portion is ggplot2 package
library(ggplot2)
str(mpg) ## comes with ggplot2 package
## displ is size of engine, hwy is highway mileage, drv is 4-wheel, front-wheel, or rear-wheel
table(mpg$manufacturer) ## just exploring the data a bit

qplot(displ, hwy, data=mpg)
plot(hwy ~ displ, data=mpg) ## compared qplot to base-plot
qplot(displ, hwy, color = drv, data=mpg) ## adds colors by drive type, adds legend automatically
qplot(displ, hwy, data=mpg, geom=c("point", "smooth")) ## adds smoother, default is lowess (?)
qplot(hwy, data=mpg, fill = drv) ## makes histogram, fills bars by drive-type. Knows to make histogram b/c only one variable passed to fx

qplot(displ, hwy, data=mpg, facets = .~drv) ## panels by drive type
qplot(hwy, data=mpg, facets = .~drv, binwidth = 2) ## histogram in panels
qplot(hwy, data=mpg, facets = drv~., binwidth = 2) ## right-hand side of facets is columns, left-hand side is row
qplot(hwy, data=mpg, facets = fl~drv, binwidth = 2) ## my test adding another facet, produced 5 x 3 graphs

qplot(displ, hwy, color = drv, shape = drv, data=mpg) ## test to see if you can both color and shape for same factor - it worked

## in lecture ggplot5, showing different axis limits:
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100 ## outlier
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))
g <- ggplot(testdat, aes(x = x, y = y))
summary(g) ## gives data of ggplot object

g + geom_line() ## default is plot showing outlier
ggplot(testdat, aes(x=x,y=y))+geom_point() ## testing syntax, don't have to create g first...
g+geom_line()+ylim(-3,3) ## dropped the outlier; subsetted the data based on ylim
g+geom_line()+coord_cartesian(ylim = c(-3,3)) ## includes outlier, but not shown on plot

## example on cutting data was done with MAACS. I replicated example using airquality
str(airquality)
quantile(airquality$Ozone, seq(0,1,length=4), na.rm=TRUE) ## gives 0, 33.33%, 66.67%, 100%
## cut() creates a categorical variable based on the categories provided.
## this code creates 3 levels, 0-33.33%, 33.33%-66.67%, 66.67%-100%)
## By default, the right-hand side of range is closed, left-hand side is open.
airquality$ozcat <- cut(airquality$Ozone,quantile(airquality$Ozone,seq(0,1,length=4), na.rm=TRUE))
summary(airquality$ozcat)

## Quiz 2, Question 2
library(nlme)
library(lattice)
xyplot(weight~Time|Diet, BodyWeight) ## 3 panels, relationship between weight & Time, by Diet

## Quiz 2, Question 5
?trellis.par.set ## Help file explains how this can be used to refine appearance of lattice plots

## Quiz 2, Question 7
library(datasets)
data(airquality)
airquality=transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data=airquality, facets=.~Month) ## produced a graph of wind vs. ozone by month

qplot(Wind, Ozone, data=airquality, facets = .~factor(Month)) ## checked add'l possible answer. Code didn't work
## Error in layout_base(data, cols, drop = drop) : At least one layer must contain all variables used for facetting

## Quiz 2, Quesiton 10
qplot(votes, rating, data = movies)
qplot(votes, rating, data = movies) + geom_smooth() ## adds a smoother line
