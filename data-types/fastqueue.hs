-- Fastqueue: zwei Stacks, umgekehrt; auf den einen wird hinzugefügt, vom
-- anderen wird abgelesen/entfernt; wenn der untere Stack leer wird, 
-- werden die Elemente vom oberen umgekehrt raufkopiert (reshuffle)

-- 1. Fastqueue als Liste (Stack)
-- Helper functions
backEl [x] = x
backEl (x:xs) = backEl xs

initL [x] = []
initL (x:xs) = x : (initL xs)

-- fst: writeQueue, snd: readQueue
emptyQueue = ([], [])

isEmptyQueue ([], []) = True
isEmptyQueue (backs, fronts) = False

enqueue x (backs, fronts) = ((x:backs), fronts)

reshuffle ([], fronts) = fronts
reshuffle (backs, fronts) = reshuffle ((initL backs), ((backEl backs) : fronts))

dequeue ([], []) = error "dequeue: Queue empty"
dequeue (backs, []) = dequeue (backs, (reshuffle (backs, [])))
dequeue (backs, (x:fronts)) = (backs, fronts) 

headQueue ([], []) = error "dequeue: Queue empty"
headQueue (backs, []) = headQueue (backs, (reshuffle (backs, [])))
headQueue (backs, (x:fronts)) = x

-- 2. Fastqueue als abstrakter Datentyp (Stack)
data Stack a = EmptyStack | Node a (Stack a) deriving Show

emptyStack = EmptyStack

isEmptyStack EmptyStack = True
isEmptyStack (Node x xs) = False

pushStack x xs = (Node x xs)

popStack EmptyStack  = error "popStack: empty arg"
popStack (Node x xs) = xs

topStack EmptyStack  = error "popStack: empty arg"
topStack (Node x xs) = x


d_emptyQueue = (EmptyStack, EmptyStack)

d_isEmptyQueue (EmptyStack, EmptyStack)      = True
d_isEmptyQueue (Node b backs, Node f fronts) = False

d_enqueue x (backs, fronts) = (Node x backs, fronts)

d_reshuffle (EmptyStack, EmptyStack) = error "Stack completely empty"
d_reshuffle (EmptyStack, stackfront) = stackfront
d_reshuffle (stackback, stackfront) = d_reshuffle (popStack stackback, pushStack (topStack stackback) stackfront)

d_dequeue (stackback, EmptyStack) = d_dequeue (stackback, (d_reshuffle (stackback, emptyStack)))
d_dequeue (stackback, Node front stackfront) = (stackback, stackfront)

d_headQueue (stackback, EmptyStack) = d_headQueue (stackback, (d_reshuffle (stackback, emptyStack)))
d_headQueue (stackback, Node front stackfront) = front
