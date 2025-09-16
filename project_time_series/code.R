# Podstawowa analiza
library(readxl)
dane_pierwotne <-read_excel("../data/dane.xlsx",col_types = c("text", "numeric"))
head(dane_pierwotne)
library(forecast)
library(tseries)
library(fBasics)
library(timeSeries)
library(lmtest)
library(TTR)


dane <- data.frame(dane_pierwotne)
X <- ts(dane[2], start = c(1991,7),frequency = 12)
plot.ts(X)

stationarity_test <-adf.test(X,alternative = "stationary",k = 2)
ifelse(stationarity_test$p.value<0.05,"Szereg jest stacjonarny","Szereg jest niestacjonarny")

explosive_test <-adf.test(X,alternative = "explosive",k = 2)
ifelse(explosive_test$p.value<0.05,"Szereg jest eksplozywny","Szereg jest nieeksplozywny")


trend_test <- kpss.test(X,null="Trend",lshort = TRUE)
ifelse(trend_test$p.value<0.05,"Szereg ma trend","Szereg nie ma trendu")


basic_stats<-basicStats(X,ci=0.95)
basic_stats


# Dekompozycja szeregu
plot(X)

dane_zdekomponowane <- decompose(X,type="additive",filter = NULL)

## Sezonowość szeregu
plot(dane_zdekomponowane$seasonal)

## Trend szeregu
plot(dane_zdekomponowane$trend)

## Odchylenia losowe
plot(dane_zdekomponowane$random)


# Tworzenie modelu
X2 <- HoltWinters(X,seasonal = "additive")
plot(X2)


# Przewidywwany trend
XForecast <- forecast(X2,h=12)
plot(XForecast)


# Testowanie prognozy
acf(na.omit(XForecast$residuals), lag.max=20)

box_test<-Box.test(XForecast$residuals, lag=20, type="Ljung-Box")
ifelse(box_test$p.value<0.05,"Występuje istotna autokorelacja w błędch prognozy","Zerowa autokorelacja w błędach prognozy")