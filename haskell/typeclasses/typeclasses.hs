class Visible a where
    toString :: a -> String
    size :: a -> Int

instance Visible Bool where
    toString True = "True"
    toString False = "False"
    
    size _ = 1

instance Visible Char where
    toString ch = [ch]
    
    size ch = 1

-- there can be various type constraints on inputs
restricted_func :: (Eq a, Visible a) => a -> a -> String
restricted_func a b 
    | a == b = toString a 
    | otherwise = "not " ++ toString a
