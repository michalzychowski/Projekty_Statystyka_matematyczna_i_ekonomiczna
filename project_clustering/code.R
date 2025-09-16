# Przygotowanie danych
library(readxl)
dane <- read_excel("data/dane.xlsx")
head(dane)
library(lmtest)
library(cluster)
library(fpc)
library(MASS)


Frame1 <- data.frame(dane)
K <- ncol(Frame1)

Frame2 <- data.frame(scale(Frame1[,2:K]))

X <- data.frame(Frame1[1],Frame2)
head(X)


# Grupowanie danych
dist.X <- dist(X[2:K],method = "euclidian")
round(dist.X,2)

CW<-hclust(dist.X,method = "ward.D2",members = NULL)
A1<-plot(CW,labels = X[,1],main="Dendogram województw")


# Tworzenie klastrów
clust3<-cutree(CW,k=3)
clust4<-cutree(CW,k=4)


showc3 <- lapply(1:3,function(which.group)Frame1[1][clust3==which.group,])
showc3


showc4 <- lapply(1:4,function(which.group)Frame1[1][clust4==which.group,])
showc4


# Porównanie klastrów
S3<-cluster.stats(dist.X,clust3)
S3$cluster.size

S3$average.distance

S3$separation.matrix

S3$average.between

S3$average.within


S4<-cluster.stats(dist.X,clust4)
S4$cluster.size

S4$average.distance

S4$separation.matrix

S4$average.between

S4$average.within


# Wybór lepszego
ifelse(S3$wb.ratio<=S4$wb.ratio,"Klastorwanie pierwsze jest lepsze","Klastorwanie drugie jest lepsze")

ifelse(S3$pearsongamma>=S4$pearsongamma,"Klastorwanie pierwsze jest lepsze","Klastorwanie drugie jest lepsze")

ifelse(S3$dunn2>=S4$dunn2,"Klastorwanie pierwsze jest lepsze","Klastorwanie drugie jest lepsze")