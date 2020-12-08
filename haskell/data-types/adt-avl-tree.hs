data MyTree a = EmptyTree | Node (MyTree a) a (MyTree a) deriving Show

height EmptyTree = 0
height (Node l c r) = max (height l) (height r) + 1

avlFactor (Node l c r) = abs(height l - height r)

-- Wir gehen von einem AVL-Baum aus und fügen dann ein
-- Alternativ können wir davor vollständig rebalancieren