-- Faltungsfunktionen "falten" Listen auf einen Wert zusammen
-- Motivation für Faltungsfunktionen
sumcool [] = 0 -- Startwert
sumcool (x:xs) = x + sum xs -- Funktion

andcool [] = True -- Startwert
andcool (x:xs) = x && and xs -- Funktion

-- Allgemein
-- Ziel: Funktion, die als Argumente eine andere Funktion, einen Startwert und eine Liste nimmt, und diese Liste herunterfaltet

-- Wertet aus zu f (a, f (b, f(c, f(d, st)))) ...
faltenrechts :: (a -> b -> b) -> b -> [a] -> b
faltenrechts f st [] = st
faltenrechts f st (x:xs) = f (x) (faltenrechts f st xs)

-- Wertet aus zu f( f( f( f(a, st), b), c), d)
faltenlinks :: (a -> b -> a) -> a -> [b] -> a 
faltenlinks f st [] = st
faltenlinks f st (x:xs) = faltenlinks f (f st x) xs


-- Weitere higher-order functions
mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter r (x:xs) = [x | x <- (x:xs), r x]

verkettung :: (b -> c) -> (a -> b) -> (a -> c)
verkettung f g x = f (g x)

myallgen :: (a -> Bool) -> [a] -> Bool
myallgen p (x:xs) = foldl (&&) True [p x | x <- (x:xs)]

-- myallfold :: (a -> Bool) -> [a] -> Bool
myallfold p xs = foldl ((&&).p) True xs

myallmap :: (a -> Bool) -> [a] -> Bool
myallmap p xs = foldl (&&) True (map p xs)

myallmapcool :: (a -> Bool) -> [a] -> Bool
myallmapcool p = (foldl (&&) True) . (map p) -- verkürzte Schreibweise. spart xs

mymapfold :: (a -> b) -> [a] -> [b]
mymapfold f xs = foldr ((:).f) [] xs

mylengthfold :: [a] -> Int
mylengthfold xs = foldr ((+).one) 0 xs
    where one x = 1
