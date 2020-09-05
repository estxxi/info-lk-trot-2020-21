main::IO()
main=return()

sklave1::Ord a => [a]->[a]->[a]	
sklave1 [] akk = akk
sklave1 (x:xs) [] = sklave1 xs [x]
sklave1 (x:xs) (y:ys) = if x<=y then sklave1 xs (y:(x:ys)) else (y:(sklave1 (x:xs) (y:ys)))

sklave2::Ord a => [a]->[a]->[a]	  
sklave2 [] akk = akk
sklave2 (x:xs) [] = sklave2 xs [x]
sklave2 (x:xs) (y:ys) =if x>=y then sklave2 xs (y:(x:ys)) else (y:(sklave2 (x:xs) (y:ys)))

insort::Ord a => String ->[a] -> [a]
insort b a = if b == "<" then sklave1 a [] else if b == ">" then sklave2 a [] else error "Du Dödel!"

		
		
	
qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) = qsort lesser ++ [x] ++ qsort greater
    where
        lesser  = filter (< x) xs
        greater = filter (>= x) xs

qsortr :: Ord a => [a] -> [a]
qsortr [] = []
qsortr (x:xs) = qsortr greater ++ [x] ++ qsortr lesser
    where
		lesser  = filter (< x) xs
		greater = filter (>= x) xs

bubbles:: Ord a=>[a]->[a]
bubbles [] = []
bubbles (x:y:zs) = if x<=y then (x:(bubbles(y:zs))) else (y:(bubbles(x:zs)))

