-- Liste, aber selbstgemacht
data MyList a = Empty | Node a (MyList a)

empty = Empty

isEmpty Empty = True
isEmpty (Node x xs) = False

myHead Empty = error "List empty"
myHead (Node x xs) = x

myEnd Empty = error "List empty"
myEnd (Node x Empty) = x
myEnd (Node x xs) = myEnd xs

-- will nicht ausgeben, unklar
myMap f Empty = Empty 
myMap f (Node x xs) =  (Node (f x) (myMap f xs))

-- will nicht ausgeben, unklar
myFilter p Empty = Empty
myFilter p (Node x xs) | p x = (Node x (myFilter p xs))
                       | otherwise = myFilter p xs

myFold f st Empty = st
myFold f st (Node x xs) = f (myFold f st xs) x

indexAccess i Empty = error "Index too large/small"
indexAccess 1 (Node x xs) = x
indexAccess i (Node x xs) = indexAccess (i - 1) xs

-- Algebraischer Datentyp für eine Liste, die vorne und hinten anfügt
data TupleList a b = EmptyDouble | NodeDouble a (TupleList a b) b deriving Show
