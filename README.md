# Projekty - Statystyka matematyczna i ekonomiczna
## Opis
Projekty na przedmiot "Statystyka matematyczna i ekonomiczna" na II roku studiów inżynierskich na kierunku Informatyka i ekonometria na UR. Repozytorium zawiera trzy projekty realizowane w języku R, które ilustrują wybrane metody statystyki matematycznej i ekonomicznej:
* Klasteryzacja – grupowanie województw na podstawie wybranych zmiennych społeczno-gospodarczych przy użyciu metody hierarchicznej.
* Szeregi czasowe – analiza, dekompozycja i prognozowanie danych miesięcznych metodą Holt-Wintersa.
* Drzewa klasyfikacyjne – budowa i testowanie modeli klasyfikacyjnych dla danych opisowych.

## Technologie
Projekt został wykonany przy użyciu:
* R
* RStudio
* Biblioteki:
    * readxl (import danych z Excela)
    * MASS, lmtest, fBasics, timeSeries (statystyka i testy)
    * rpart, rpart.plot, party, maptree (drzewa decyzyjne)
    * forecast, tseries, TTR (szeregi czasowe, prognozowanie)
    * cluster, fpc (analiza skupień)

## Wymagania
Do uruchomienia projektu potrzebne są:
* Zainstalowane środowisko R (np. R + RStudio)
* Zainstalowane wymienione biblioteki (install.packages(...))

## Instrukcja uruchomieniagit
1. Zainstaluj wymagane komponenty
2. Sklonuj repozytorium komendą `git clone https://github.com/michalzychowski/Projekty_Statystyka_matematyczna_i_ekonomiczna.git`
3. Otwórz wybrany projekt w RStudio
4. Uruchom kod krok po kroku, aby zobaczyć analizę, wyniki i wykresy.

## Uwagi
Podział zbioru na treningowy i testowy w przypadku drzew klasyfikacyjnych jest losowy – przy ponownym uruchomieniu wyniki mogą się różnić.

Do poprawnego działania wymagany jest plik dane.xlsx w odpowiednim katalogu (data/).

## Licencja
Projekt jest dostępny na licencji [MIT](LICENSE).