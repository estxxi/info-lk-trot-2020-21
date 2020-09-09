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
l_emptyQueue = []

l_isEmptyQueue [] = True
l_isEmptyQueue (x:xs) = False

l_enqueue x []     = [x] 
l_enqueue x (y:ys) = (y : (l_enqueue x ys))

l_dequeue xs = dequeueHelp xs (l_isEmptyQueue xs)
         where dequeueHelp xs True      = error "dequeue: empty queue"
               dequeueHelp (x:xs) False = xs

l_headQueue xs = headQueuehelp xs (l_isEmptyQueue xs)
           where headQueuehelp xs True      = error "headqueue: empty queue" 
                 headQueuehelp (x:xs) False = x