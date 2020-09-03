-- Queue: s. Axiome, push/enqueue hinten, pop/dequeue vorne, top/head vorne
-- Queue als algebraischer Datentyp
data Queue a = EmptyQueue | Node (Queue a) a deriving Show

emptyQueue = EmptyQueue

isEmptyQueue EmptyQueue = True
isEmptyQueue (Node xs x) = False

enqueue x xs = (Node xs x)

dequeue EmptyQueue          = error "dequeue: empty arg"
dequeue (Node EmptyQueue x) = EmptyQueue
dequeue (Node xs x)         = (enqueue x (dequeue xs))

headQueue EmptyQueue  = error "head: empty arg"
headQueue (Node xs x) = x

-- Queue als Liste
emptySnek = []

isEmptySnek [] = True
isEmptySnek (x:xs) = False

ensnek x []     = [x] 
ensnek x (y:ys) = (y : (ensnek x ys))

desnek (x:xs) = xs

headSnek xs = headSnekhelp xs (isEmptySnek xs)
          where headSnekhelp xs True      = error "headsnek: empty snek" 
                headSnekhelp (x:xs) False = x  