searchrec x [] = False
searchrec x (y:xs)  | x == y    = True
                    | otherwise = searchrec x xs


searchmap x xs = foldr (||) False (map (== x) xs)


searchfilter x xs | length (filter (== x) xs) > 0 = True
                  | otherwise = False



-- bisei :: a -> [a] -> (a -> [a] -> Int -> Int -> Int -> Int) -> Int
bisei x xs = searchf x xs 0 ((length xs) `div` 2) ((length xs) - 1)
    where   searchf x xs low mid high   | low > high        = (-1)
                                        | x == (xs !! mid) = mid
                                        | x < (xs !! mid)  = searchf x xs low       ((low + high) `div` 2) (mid - 1)
                                        | x > (xs !! mid)  = searchf x xs (mid + 1) ((low + high) `div` 2) high