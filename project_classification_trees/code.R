# Drzewa klasyfikacyjne

# Przygotowanie danych
library(readxl)
dane <- read_excel("data/dane.xlsx")
library(MASS)
library(maptree)
library(rpart)
library(rpart.plot)
library(party)
library(class)

dane_pierwotne <- data.frame(dane)
Dane <- na.omit(data.frame(dane_pierwotne))
head(Dane)


# Tworzenie zbioru uczącego oraz testowego
Indeksy <- sample(1:nrow(dane),nrow(dane)/2,replace = FALSE)

zbior_uczacy = dane[Indeksy, ]
zbior_testowy = dane[-Indeksy, ]

head(zbior_uczacy)
head(zbior_testowy)


# Tworzymy model drzewa
Drzewo <- rpart(zbior_uczacy$`Prawo jazdy`~.,zbior_uczacy,method = "class")

Drzewo$parms
Drzewo$numresp

Model.optimal<-which.min(Drzewo$cptable[,4])
CP.optimal<-Drzewo$cptable[Model.optimal,1]
Drzewo2<-prune(Drzewo,cp=Model.optimal)


# Weryfikacja naszych modeli
prediction1<-predict(Drzewo,zbior_uczacy,type = "class")

print("Tabela dobroci klasyfikacji")
table(predykacja=prediction1,prawdziwe=zbior_uczacy$`Prawo jazdy`)

print("Obliczanie błędu predykcji")
error1<-mean(prediction1 != zbior_uczacy$`Prawo jazdy`)
error1

prediction2<-predict(Drzewo2,zbior_uczacy,type = "class")

print("Tabela dobroci klasyfikacji")
table(predykacja=prediction2,prawdziwe=zbior_uczacy$`Prawo jazdy`)

print("Obliczanie błędu predykcji")
error2<-mean(prediction2 != zbior_uczacy$`Prawo jazdy`)
error2


# Testowanie na zbiorze testowym
TPrediction1<-predict(Drzewo,zbior_testowy,type = "class")
errorT1<-mean(TPrediction1 != zbior_testowy$`Prawo jazdy`)
print("Błąd predykcji drzewa")
errorT1

TPrediction2<-predict(Drzewo2,zbior_testowy,type = "class")
errorT2<-mean(TPrediction2 != zbior_testowy$`Prawo jazdy`)
print("Błąd predykcji drzewa Przyciętego")
errorT2


# Rysowanie drzewa
rpart.plot(Drzewo,type = 4,extra="auto")
rpart.plot(Drzewo2,type = 4,extra="auto")