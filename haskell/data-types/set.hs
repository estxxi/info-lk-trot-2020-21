-- ADT Set

-- Funktionen:
-- empty :: Set(a)
-- isEmpty :: Set(a) -> Bool
-- isEl :: a -> Set(a) -> Bool
-- insert :: a -> Set(a) -> Set(a)
-- remove :: a -> Set(a) -> Set(a) (kann auch eine partielle Funktion sein)

-- Axiome: (Nummerierung unklar, Auswahl halbwegs von Trot bestätigt)
-- isEmpty empty = True
-- isEmpty (insert a set) = False
-- isEl a (insert a set) = True
-- isEl a (remove a set) = False
-- isEL a (remove a (insert a set)) = False
-- isEl a (remove a (insert a (insert a set))) = False 

empty = []

isEmpty [] = True
isEmpty (x:xs) = False

isEl el [] = False
isEl el (x:xs) | el == x = True
               | otherwise = isEl el xs

insert el xs = insertHelp el xs (isEl el xs)
         where insertHelp el xs True = xs
               insertHelp el [] False = [el]
               insertHelp el xs False = el:xs

remove el (x:xs) | el == x = xs
                 | otherwise = x : (remove el xs)

cardinality xs = cardinalityHelp xs 0
    where cardinalityHelp [] n = n
          cardinalityHelp (x:xs) n = cardinalityHelp xs (n+1)