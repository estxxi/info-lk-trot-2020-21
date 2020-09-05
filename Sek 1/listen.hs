{- 
	Datei: liste.hs
	Datum: 04.10.2018
	Autor: Ike
	-}
listeA :: [a]
listeA = []  --leere Liste
listeB :: [Char]
listeB = ""  --leerer String, leere Liste von Zeichnen (Char)
listeA1 :: Int -> [Int]
listeA1 x = x:listeA
-- : ist der Cons-Operator
listeB1 :: Char -> String
listeB1 x = x:listeB 

gibKopf :: [Int] -> Int
gibKopf []            = error "leere Liste, du Dödel" 
gibKopf (kopf:schwanz) =  kopf 


laenge :: [a] -> Int
laenge [] = 0
laenge (x:rest) = 1 + laenge rest

letztes :: [a] -> a
letztes [] = error "Leere Liste du DödSel"
letztes [x] = x
letztes (x:xs) = letztes xs
