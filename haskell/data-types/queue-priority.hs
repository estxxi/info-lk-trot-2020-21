emptyQueue = []

isEmptyQueue [] = True
isEmptyQueue (x:xs) = False

-- Annahme: eingegebene prio-q ys ist bereits nach prio sortiert, also
-- mit den angegebenen "Konstruktoren" emptyQueue und enqueue gebaut
enqueue (prio, x) []     = [(prio, x)] 
enqueue (prio, x) (y:ys) | prio <= (fst y) = (y : (enqueue (prio, x) ys))
                         | otherwise       = ((prio, x) : y : ys)

dequeue xs = dequeueHelp xs (isEmptyQueue xs)
         where dequeueHelp xs True      = error "dequeue: empty queue"
               dequeueHelp (x:xs) False = xs

headQueue xs = headQueuehelp xs (isEmptyQueue xs)
           where headQueuehelp xs True      = error "headqueue: empty queue" 
                 headQueuehelp (x:xs) False = x
