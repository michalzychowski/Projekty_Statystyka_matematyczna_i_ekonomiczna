
# Clastering
# Michał Żychowski
# 2023-05-24

  
  
  
# Przygotowanie danych
# Zacznijmy od zaimportowania naszej bazy danych oraz niezbędnych bibliotek.
library(readxl)
dane <- read_excel("data/dane.xlsx")
head(dane)
library(lmtest)
library(cluster)
library(fpc)
library(MASS)



# Generujemy ramkę danych i przypisujemy liczbę kolumn do zmiennej.
Frame1 <- data.frame(dane)
K <- ncol(Frame1)

# Standaryzujemy wartości zmiennych - standaryzacja Gaussa
Frame2 <- data.frame(scale(Frame1[,2:K]))


# Generujemy ramkę z przeskalowanymi danymi
X <- data.frame(Frame1[1],Frame2)
head(X)


# Grupowanie danych
# Do przeprowadzenia klasteryzacji konieczne jest stworzenie macierzy odległości, przy czym wybieramy metodę euklidesową.
dist.X <- dist(X[2:K],method = "euclidian")
round(dist.X,2)


# Obecnie przeprowadzamy analizę naszych klastrów przy użyciu metody ward.D2 oraz generujemy wykres.
CW<-hclust(dist.X,method = "ward.D2",members = NULL)
A1<-plot(CW,labels = X[,1],main="Dendogram województw")




# Tworzenie klastrów
# Po analizie powyższego wykresu, można wywniskować, że najelpsze będzie podzielenie naszych danych na 3 lub 4 klastry. Aby tego dokonać, możemy skorzystać z poniższej komendy.

# dla 3 klastrów
clust3<-cutree(CW,k=3)
# dla 4 klastrów
clust4<-cutree(CW,k=4)



# Możemy zobaczyć przypisanie poszczególnych województw do odpowiednich klastrów.

# Dla 3 klastrów

showc3 <- lapply(1:3,function(which.group)Frame1[1][clust3==which.group,])
showc3


# Dla 4 klastórw
showc4 <- lapply(1:4,function(which.group)Frame1[1][clust4==which.group,])
showc4




# Porównanie klastrów
# Dla naszych klastórw możemy zobaczyć klika następujących parametrów

# Dla 3 klastrów
# Rozmiar


S3<-cluster.stats(dist.X,clust3)
S3$cluster.size


# Zróżnicowanie wewnątrzgrupowe
S3$average.distance


# Macierz separacji
S3$separation.matrix


# Średni dystans pomiędzy grupami
S3$average.between


# Średni dystans wewnątrz grup
S3$average.within


# Dla 4 klastrów
# Rozmiar

S4<-cluster.stats(dist.X,clust4)
S4$cluster.size


# Zróżnicowanie wewnątrzgrupowe
S4$average.distance


# Macierz separacji
S4$separation.matrix


#Średni dystans pomiędzy grupami
S4$average.between


# Średni dystans wewnątrz grup
S4$average.within


# Wybór lepszego
# Dla oceny, który podział na klastry jest lepszy, istnieje możliwość sprawdzenia trzech rzeczy:
# Stosunek między średnią grupową a różnicami pozagrupowymi

ifelse(S3$wb.ratio<=S4$wb.ratio,"Klastorwanie pierwsze jest lepsze","Klastorwanie drugie jest lepsze")


# Współczynnik gamma
ifelse(S3$pearsongamma>=S4$pearsongamma,"Klastorwanie pierwsze jest lepsze","Klastorwanie drugie jest lepsze")


# Indeks Dunna
ifelse(S3$dunn2>=S4$dunn2,"Klastorwanie pierwsze jest lepsze","Klastorwanie drugie jest lepsze")



# Podsumowanie
# Podsumowując podział na 4 klastry jest lepszy.
