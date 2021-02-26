new = []

insert key item dict = (key, item):dict

lookup key [] = error "Key not available"
lookup key (pair:dict)
    | fst pair == key = snd pair
    | otherwise = Main.lookup key dict

remove key [] = []
remove key (pair:dict)
    | fst pair == key = dict 
    | otherwise = pair: remove key dict

containsKey key [] = False 
containsKey key (pair:dict) 
    | fst pair == key = True 
    | otherwise = containsKey key dict

keys dict = map fst

items dict = map snd

size dict = foldl ((+).one) 0
    where one x = 1