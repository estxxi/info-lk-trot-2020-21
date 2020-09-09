import Data.List


-- permutationscool :: [a] -> [[a]]
-- permutationscool [a] = [[

binomcool :: Int -> Int -> Int
binomcool n k | n==0    = 1
              | n==k    = 1
              | otherwise = binomcool (n-1) k + binomcool (n-1) (k-1)


fac1 :: Int -> Int
fac1 0 = 1
fac1 n = n * fac1 (n-1) 

fac2 :: Int -> Int
fac2 n = product [1..n]

fac3 :: Int -> Int 
fac3 n = length (permutations [1..n])

fac4 :: Int -> Int
fac4 n = sum([(-1)^i * binomcool n (n-i) * (n-i)^n | i <- [0..(n-1)]])

fac5 :: Int -> Int
fac5 n = if n == 0 then 1
         else n * fac5 (n-1)

fac6 :: Int -> Int
fac6 n | (n == 0) = 1
       | otherwise = n * fac6 (n-1)


facausblick :: Int -> Int
facausblick n = foldl (*) 1 [1..n]