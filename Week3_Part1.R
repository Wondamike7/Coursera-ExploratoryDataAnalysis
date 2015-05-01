## Hierarchical Clustering
## Create random data
set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean=rep(1:3,each = 4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1),each = 4), sd=0.2)
plot(x,y,col='blue',pch=19,cex=2)
text(x+0.05, y+0.05,labels=as.character(1:12)) ## scatterplot to show simple hierarchical example

dataFrame <- data.frame(x=x,y=y)
dist(dataFrame) ## creates a matrix of distances between points
## points 5 & 6 are closest together in this example - 0.0815
min(dist(dataFrame)) ## that was a check, and returned 0.0815

distXY <- dist(dataFrame)
hClustering <- hclust(distXY) ## function to do the hierarchical clustering
plot(hClustering) ## results in dendrogram for these clusters

source("myplclust.R")
myplclust(hClustering, lab=rep(1:3, each=4), lab.col=rep(1:3, each=4))
## the myplclust function produces "prettier" dendrograms

## next is heatmap() for showing matrix data
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),] ## in the matrix call, sample just randomized the order of the pairs
heatmap(dataMatrix)

## moving on to K-Means
## using same x, y generated earlier
plot(x,y,col='blue',pch=19,cex=2)
text(x+0.05, y+0.05,labels=as.character(1:12))
kmeansObj <- kmeans(dataFrame, centers=3) ## kmeans is code for this type of clustering. Tell it the number of clusters (centers=3)
names(kmeansObj) ## 9 names in the kmeans object - cluster, centers, totss, witinss, tot.withinss, betweenss, size, iter, ifault
kmeansObj$cluster ## [1] 2 2 2 2 1 1 1 1 3 3 3 3
kmeansObj$centers 
## x      y
## 1 1.9907 2.0078
## 2 0.8905 1.0069
## 3 2.8535 0.9831

par(mar=rep(0.2,4))
plot(x,y,col = kmeansObj$cluster, pch=19, cex=2)
points(kmeansObj$centers, col=1:3, pch=3, cex=3, lwd=3) ## plotted the points again, colored by their cluster, and crosses for the centroid locations

set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj2 <- kmeans(dataMatrix, centers=3)
par(mfrow=c(1,2), mar=c(2,4,0.1,0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt="n")
image(t(dataMatrix)[, order(kmeansObj2$cluster)], yaxt="n")
## produced two heatmaps; think the lecture had an error, in using kmeansObj$cluster rather than kmeansObj2$cluster

## dimension reduction lectures
set.seed(12345)
par(mar=rep(0.2,4))
dataMatrix <- matrix(rnorm(400),nrow=40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1]) ## noisy matrix with no real pattern
heatmap(dataMatrix) ## H.C. heatmap doesn't show anything interesting either

## adding a pattern to the data:
set.seed(678910)
for (i in 1:40) {
# flip a coin
coinFlip <- rbinom(1, size = 1, prob = 0.5)
# if coin is heads, add a common pattern to that row
if (coinFlip) {
dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3),each=5)
}
}

image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1]) ## not sure I understand the image function...not explained well in lectures
## the pattern is visible though, there are several rows where the last 5 columns had 3 added to them (they look lighter?)
heatmap(dataMatrix) ## dendrogram shows columsn are easily grouped. Two clusters of 5 columns. Still no patterns on rows, random pattern

## adding pattern to rows and columns:
hh <- hclust(dist(dataMatrix))
dataMatrixOrd <- dataMatrix[hh$order,]

par(mfrow=c(1,3))
image(t(dataMatrixOrd)[,nrow(dataMatrixOrd):1])
plot(rowMeans(dataMatrixOrd),40:1, ,xlab="Row Mean",ylab="Row",pch=19)
plot(colMeans(dataMatrixOrd), xlab="Col Mean",ylab="Col",pch=19)

## svd - u and v
svd1 <- svd(scale(dataMatrixOrd)) ## scale function likely does the subtract mean, divide by std dev; need to look this up
par(mfrow=c(1,3),mar=c(1,1,1,1))
image(t(dataMatrixOrd)[,nrow(dataMatrixOrd):1])
plot(svd1$u[,1],40:1, ,xlab="Row",ylab="First left singular vector",pch=19)
plot(svd1$v[,1],xlab="Column",ylab="First right singular vector",pch=19)

plot(svd1$u[,1],40:1, ,xlab="Row",ylab="First left singular vector",pch=19) 
## plots shift in mean across rows and columns (is this svd or scale that does this?)

par(mfrow=c(1,2))
plot(svd1$d, xlab="Column",ylab="Singular Value", pch=19) ## diagonal matrix D, variance explained
plot(svd1$d^2 / sum(svd1$d^2), xlab="Column", ylab="Prop of variance explained", pch = 19)
## plots are same/similar, but second one captures proportion of variance explained rather than Raw #

pca1 <- prcomp(dataMatrixOrd, scale=TRUE) ## principal component analysis function
plot(pca1$rotation[,1], svd1$v[,1],pch=19, xlab="Principal Component 1", ylab = "Right Singular Vector 1")
abline(c(0,1)) ## shows that pca and svd line up (svd done on scaled matrix)

## more on variance explained:
constantMatrix <- dataMatrixOrd * 0
for(i in 1:dim(dataMatrixOrd)[1]) {constantMatrix[i,] <- rep(c(0,1),each=5)} ## creates constant matrix with either 1 or 0
svd2 <- svd(constantMatrix)

par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd2$d,xlab="Column",ylab="Singular Value",pch=14)
plot(svd2$d^2/sum(svd2$d^2),xlab="Column", ylab="Prop of var expl",pch=12)
## constant matrix has only one pattern - first five columns zero, second five columns 1
## all variance shown in first singular value
## only one dimension to data set

## adding second pattern:
set.seed(678910)
for (i in 1:40) {
# flip a coin
coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
# if coin is heads, add common pattern
if(coinFlip1) {dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),each=5)}
if(coinFlip2) {dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),5)}
}

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
svd3 <- svd(scale(dataMatrixOrdered))

par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rep(c(0,1), each=5), pch = 8, xlab = "column", ylab="pattern 1")
plot(rep(c(0,1), 5), pch = 4, xlab = "column", ylab="pattern 2")

par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd3$v[,1], pch = 1, ylab="First right singular vector") ## this will show the first, strongest pattern
plot(svd3$v[,2], pch = 2, ylab="Second right singular vector") ## second strongest pattern

## inject missing data
dm <- dataMatrixOrdered
dm[sample(1:100, size=40, replace=FALSE)] <- NA
svd1 <- svd(scale(dm)) ## error!

## using newly-installed impute package to generate values for the missing ones
source("http://bioconductor.org/biocLite.R")
biocLite("impute")
library(impute)

dm <- impute.knn(dm)$data ## k nearest neighbors
svd1 <- svd(scale(dataMatrixOrdered))
svd2 <- svd(scale(dm))
par(mfrow=c(2,1))
plot(svd1$v[,1],pch=3)
plot(svd2$v[,1],pch=5) ## two plots are very similar; impute worked well

## face data example
download.file("https://spark-public.s3.amazonaws.com/dataanalysis/face.rda",destfile="./data/face.rda")
load("data/face.rda")

image(t(faceData)[, nrow(faceData):1])
svd1 <- svd(scale(faceData))
plot(svd1$d^2/sum(svd1$d^2),pch=19,xlab="Singluar vector",ylab="Variance explained")

## generate approximations of the picture using different numbers of the left and right singular vectors
svd1 <- svd(scale(faceData))
# %*% is matrix multiplication
# Here svd1$d[1] is a constant
approx1 <- svd1$u[,1] %*% t(svd1$v[,1]) * svd1$d[1]
# In these examples we need to make the diagonal matrix out of d
approx5 <- svd1$u[,1:5] %*% diag(svd1$d[1:5])%*% t(svd1$v[,1:5])
approx10 <- svd1$u[,1:10] %*% diag(svd1$d[1:10])%*% t(svd1$v[,1:10]) ## t must be transposing matrix; why do we transpose when we use image?

par(mfrow=c(2,2))
image(t(faceData)[,nrow(faceData):1])
image(t(approx10)[,nrow(approx10):1])
image(t(approx5)[,nrow(approx5):1])
image(t(approx1)[,nrow(approx1):1])
## first 10 is pretty good approximation, first 5 is ok (you can tell it's a face) but first 1 is not good
