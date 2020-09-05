-- Datei: Rekursion.hs
-- Datum: 20.09.2018
-- Wiederholung in Haskell

--In Haskell gibt es keine Schleifen
summe :: Int->Int
--Summe der ersten n Zahlen
--Summe 3 -> 1+2+3=6
 
summe 0 = 0  --terminierender Fall 
summe n = n + summe (n-1)  --rekursiver Aufruf

--summe 4 ->  4 + summe 3
-- 		  mm-> 4 + (3 + summe 2)
--		  -> 4 + (3 + (2 + summe 1))
--        -> 4 + (3 + (2 + (1 +(0))))

-- nUngrade n -> Summe der ersten ungraden Zahlen
nUngrade :: Int->Int
nUngrade 0 = 0
nUngrade n = 2*n-1 + nUngrade (n-1)

-- wir kennen nur die Addition +
-- mul a b -> Produkt a*b ohne Mal
mul :: Int->Int->Int
mul a 0 = 0
mul 0 b = 0
mul a b = a + mul a (b-1)

--ggt a b -> größter gemeinsamer Teiler von a und b 
ggt :: Int->Int->Int
ggt a b | a==b = a
		| a>b = ggt (a-b) b
		| otherwise = ggt b a 
		
ggt2 :: Int->Int->Int
ggt2 a b | a>b = ggt2 b a
		 | a==0 = b
		 |otherwise = ggt2 (b `mod` a) a
		 

--Endrekursion (vermeidet den Speicherbedarf)
--letzter Berrechnungsschritt ist der rekursive aufruf der Funktion

summeE :: Int -> Int
summeE n = sklave n 0
	where
		sklave 0 akku = akku
		sklave n akku = sklave (n-1) (akku + n)
-- summeE 4 -> Sklave 4 0
--          -> sklave 3 (0+4) -> sklave 3 4
--          -> sklave 2 (4+3) -> sklave 2 7 
--          -> sklave 1 (7+2) -> sklave 1 9
--          -> sklave 0 (9+1) -> sklave 0 10
--          -> 10










