-- Übung
loeschen :: [a] -> [a]
loeschen [x] = [x]
loeschen [x, y] = [x]
loeschen (x:y:xs) = x: loeschen xs

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