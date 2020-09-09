
gibKopf :: [Int] -> Int
gibKopf (kopf:schwanz) =  kopf

--gibSchwanz :: [Int] -> Int
--gibSchwanz (kopf:schwanz) =  schwanz

quadlist :: [Int]->[Int]
quadlist [] = error "Leere Liste"
quadlist (x:[]) = [x^2]
quadlist (x:xs) = x^2:(quadlist (xs)) 

quadlistA ::  [Int] -> [Int]
quadlistA [] = [] 
quadlistA (x:xs) = sklave (x:xs) []
    where sklave [] akku = akku
          sklave (x:xs) akku = (sklave xs) (x^2 : akku)


istEnthalten :: [Int] -> Int -> Bool
istEnthalten [] z = False
istEnthalten (x:xs) z = if x==z then True else istEnthalten (xs) z

delErstes :: [Int] -> Int -> [Int]
delErstes [] z = []
delErstes (x:xs) z = if x==z then xs else x:(delErstes (xs) z)


beispiel x = [(a,b,c) | c<-[1..x],b<-[1..c],a<-[1..b],a^2+b^2==c^2]

alleTeiler x = [t | t<-[1..x],mod x t == 0]

zweihoch x = [2^p | p<-[1..x]]


