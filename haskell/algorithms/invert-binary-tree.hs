data MyTree a = EmptyTree | Node (MyTree a) a (MyTree a) deriving Show

insert el EmptyTree = Node EmptyTree el EmptyTree
insert el (Node l c r) 
    | c <= el = Node l c (insert el r)
    | c > el  = Node (insert el l) c r 

insertList (Node l c r) []     = Node l c r  
insertList (Node l c r) (x:xs) = insertList (insert x (Node l c r)) xs

makeTree [] = EmptyTree
makeTree xs = foldr insert EmptyTree xs

invert EmptyTree = EmptyTree
invert (Node l c r) = Node (invert r) c (invert l) 
