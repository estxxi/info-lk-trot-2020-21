-- Sortieren einer Queue unter Benutzung von Queue Operationen
-- Queue über Listen für einfachere Syntax implemetiert


-- Queue-Implementierung:
emptyQueue = []

isEmptyQueue [] = True
isEmptyQueue (x:xs) = False

enqueue x []     = [x] 
enqueue x (y:ys) = (y : (enqueue x ys))

dequeue xs = dequeueHelp xs (isEmptyQueue xs)
       where dequeueHelp xs True      = error "dequeue: empty queue"
             dequeueHelp (x:xs) False = xs

headQueue xs = headQueuehelp xs (isEmptyQueue xs)
          where headQueuehelp xs True      = error "headqueue: empty queue" 
                headQueuehelp (x:xs) False = x  

reverseQueue [] = []
reverseQueue xs = enqueue (headQueue xs) (reverseQueue (dequeue xs))


-- Sortierung:
-- Erklärung der Implementierung s. stacksort.hs
-- Unterschied: pushStack xs wird durch reverse (enqueue (reverse xs)) "ersetzt"
-- Die Stackoperationen in reverseQueue werden nicht gezählt.
listgenQueue xs fin = listgenQueueHelp xs [] [] (reverseQueue fin) 1
    where listgenQueueHelp xs med inter fin step 
                                           | fin == [] = (med, step) 
                                           | isEmptyQueue xs = listgenQueueHelp inter med [] fin (step + 1)
                                           | headQueue xs == headQueue fin = listgenQueueHelp (dequeue xs) (reverse (enqueue (headQueue xs) (reverse med))) inter (dequeue fin) (step + 3)
                                           | headQueue xs /= headQueue fin = listgenQueueHelp (dequeue xs) med (reverse (enqueue (headQueue xs) (reverse inter))) fin (step + 2)
