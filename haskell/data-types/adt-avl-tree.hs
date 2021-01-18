-- FUNKTIONIERT NICHT

data MyTree a = EmptyTree | Node (MyTree a) a (MyTree a) deriving Show

-- Höhe eines Baumes (längster Weg)
height EmptyTree = 0
height (Node l c r) = max (height l) (height r) + 1

-- AVL-Faktor -> Maß für das Gleichgewicht des Baumes
avlFactor (Node l c r) = abs(height l - height r)

-- Findet Elter eines Elements (einer Node), notwendig für Retracing
-- Elemente sind mit Einfügungmethode eindeutig, also auch Eltern
parent el (Node (Node ll l lr) c (Node rl r rr)) 
    | el == l || el == r = Node (Node ll l lr) c (Node rl r rr)
    | el < c = parent el (Node ll l lr)
    | el > c = parent el (Node rl r rr) 
-- EmptyTree ist exhaustive pattern, da sonst das erste pattern passt
parent el (Node (Node ll l lr) c EmptyTree)
    | el == l = Node (Node ll l lr) c EmptyTree
    | el < l = parent el ll
    | el > l = parent el lr
parent el (Node EmptyTree c (Node rl r rr))
    | el == r = Node EmptyTree c (Node rl r rr)
    | el < r = parent el rl
    | el > r = parent el rr
parent el (Node EmptyTree c EmptyTree) = error "el not in tree/el is global root"
parent el EmptyTree = error "el not in tree/el is global root"
-- el == c kommt nicht vor, da sonst der parent von c bereits ausgegeben wurde
-- Ausnahme: el ist global root, dann gibts keinen parent

-- Ab node point im Baum (Node l c r) wollen wir den subtree (Node pl point pr)
replaceSubtree point (Node pl point pr) (Node l c r)

rotL 

rotR 

rotRL

rotLR


-- Wir gehen von einem AVL-Baum aus und fügen dann ein
-- Alternativ können wir davor vollständig rebalancieren

insert el (Node l c r) = retraceins el (parent el (insertbasic el (Node l el r))) (insertbasic el (Node l c r))
-- Problem: gibt nur korrigierten part zurück
    where 
        insertbasic el EmptyTree = Node EmptyTree el EmptyTree
        insertbasic el (Node l c r)
            | el == c = Node l c r
            | el > c = Node l c (insert el r)
            | el < c = Node (insert el l) c r 
        
        -- args: el, dass retraced wird; subtree des Elter von el; vollständiger, nicht-balancierter Baum
        retraceins el (Node pl pc pr) (Node l c r) 
            -- Wenn eine node Faktor 0 hat, sind wir fertig, wir geben den Gesamtbaum zurück, aber
            -- ersetzen den retraceten path
            | avlFactor (Node pl pc pr) == 0 = replaceSubtree pc (Node pl pc pr) (Node l c r) 
            -- avlFactor nicht 0, aber ok: wir müssen weiter retracen, aber nicht rebalancieren
            | abs (avlFactor (Node pl pc pr)) < 2 = retraceins pc (replaceSubtree pc (Node pl pc pr) (parent pc (Node l c r))) (Node l c r)
            -- avlFactor außerhalb der bounds: wir müssen rebalancieren
            -- Wie genau fügen wir den rebalancierten part rekursiv wieder ein?
            -- Könnte ok sein, da wir immer den gesamten subtree nehmen
            | otherwise = retraceins el (rebalance (Node pl pc pr)) (Node l c r)