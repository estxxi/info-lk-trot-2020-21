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

myMap f (Node x Empty) = (Node (f x) Empty) 
myMap f (Node x xs) = (Node (f x) (myMap f xs))

myFold f st Empty = st
myFold f st (Node x xs) = f (myFold f st xs) x

myFilter p Empty = True
myFilter p xs = myFold ((&&).p) True xs

indexAccess i Empty = error "List empty"
indexAccess 0 (Node x Empty) = x
indexAccess i (Node x xs) = indexAccess (i - 1) xs

-- Algebraischer Datentyp für eine Liste, die vorne und hinten anfügt
data TupleList a b = EmptyDouble | NodeDouble a (TupleList a b) b deriving Show
