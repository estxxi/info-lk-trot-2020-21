-- FUNKTIONIERT NICHT, FRAGEN RELATIV VOLLSTÄNDIG
------------------------------------------------------------------------------
------------- Fragen -------------
-- Wie ist er aufgebaut?
-- Normaler Binary Tree mit Zusatzinfo der Farbe, Regeln:
--    - Each node is either red or black.
--    - (The root is black.)
--    - All leaves are black.
--    - If a node is red, then both its children are black.
--    - Every path from a given node to any of its descendant leaves goes 
--      through the same number of black nodes.
-- Rote nodes "entstehen" bei insert

-- Wie kommt es, dass er ausbalanciert ist?
-- Die letzte Regel gibt ein gemeinsames Maß für die ungefähre Länge aller 
-- Pfade. Das theoretische Differenzmaximum wäre zwischen einem rein schwarzen
-- Pfad, und einem Pfad mit abwechselnd roten und schwarzen nodes. 
-- Für den Höhenunterschied von einer node aus gilt also
-- h_min  \leq 0.5*h_max 

-- Wie kann man etwas einfügen?
-- s. Implementierung (todo)

-- Was passiert beim Löschen eines Elements? 
-- s. Implementierung (todo)

-- Was macht ihn schlechter als einen AVL-Baum? 
-- Die Balancierung beim AVL-Baum ist bei "Nähe" von zwei Pfaden strikter als
-- beim RS Baum bzw. liegt in einem kleineren Intervall. 
-- Nähe definieren wir ungefähr als das Maximum der Anzahl der Nodes, die zwischen 
-- leaf der Pfade und dem ersten gemeinsamen Knoten liegen.

-- Wie kommt es, dass er besser ist, als ein AVL-Baum (behauptet er jedenfalls 
-- selbst)? 
-- Der RS Baum scheint skalierbarer, um Faktor beim AVL-Baum zu berechnen müssen 
-- wir den gesamten subtree traversieren, was bei großen Bäumen dauern kann. 
-- Beim RS Baum müssen wir nur Farben in der Umgebung korrigieren (zumindest
-- bei insert).

-- Welche eleganten Möglichkeiten hat man, ihn in Haskell zu implementieren? 
-- s. Implementierung (todo), na ja, "elegant"
-- Verbesserungsideen in den Kommentaren verstreut

-- Wie schafft man am besten eine Implementierung in TypeScript? 
-- Ähm, hm, generics für den Baum, weiter mal schauen

-- Wäre es u.U. möglich die Eigenschaft des Ausbalanciert-Sein für einen ADT 
-- in einem? Axiom zu formulieren?

-- g, x, c \in G;
-- l, r \in G \cap {empty}; 
-- n \in N;
-- Node(l c r) \in RBTree(g); 
-- Colour \in {r, b}

-- Leaf(c) := Node(empty c empty)

-- empty :: RBTree(g)
-- isEmpty :: RBTree(g) -> Bool
-- insert :: x -> RBTree(G) -> RBTree(G)
-- delete :: x -> RBTree(G) -/-> RBTree(G)
-- element :: x -> RBTree(g) -> Bool
-- ...
-- colour :: Node(g) -> Colour
-- blacklength :: Node(g) -> Leaf(c) -/-> n

-- Standardaxiome für empty, isEmpty, insert, delete, element, ...
-- Farbregeln: 
--  - Each node is either red or black.: colour ordnet jeder node r oder b zu,
--    haben wir in Funktionendeklarationen
--  - (The root is black.): colour Root(c) == b (dafür müssen wir root 
--    definieren, wofür wir parent brauchen würden, was alles sehr aufwendig macht
--    also sag ich das "einfach so")
--  - All leaves are black.: colour Leaf(c) == b
--  - If a node is red, then both its children are black.: 
--    (\forall Node(l c r) | colour c == r): colour l == b && colour r == b
--  - Einfügeregel: insert x RBTree(g) => colour x == r
--  - Every path from a given node to any of its descendant leaves goes 
--    through the same number of black nodes.:
--    (\exists n \forall Node(l1 c1 r1) \forall Leaf(l2 c2 r2)): 
--    blacklength Node(l1 c1 r1) Leaf(l2 c2 r2) == n || n. def.
-- Jetzt braucht man aber noch ein Axiomenschema für blacklength
------------------------------------------------------------------------------

data RBTree a = EmptyTree | Node (RBTree a) (a, Char) (RBTree a) deriving Show

------------------------------------------------------------------------------
-- Erste Idee: colourcheck für einen gesamten Baum, grundsätzlich verworfen, 
-- code ist aber interessant

-- paths findet alle Wege von root zu leafs, gibt eine Liste von paths zurück.
-- Ein path wird als Liste der Elemente auf dem Weg gespeichert, ein Element
-- hat die Form (a, Char).
-- Problem: Was machen wir bei den leafs (EmptyTree)? Diese müssen auch Form
-- (a, Char) zurückgeben, und in der Definition des Trees ist nur Typ a 
-- erlaubt (nicht Maybe a, also geht Nothing nicht; nicht Integer, also geht
-- eine bestimmte Zahl auch nicht)
-- Idee: EmptyTree nimmt das Element, dass dem path zuletzt hinzugefügt wurde, 
-- also parent von EmptyTree (Noch nicht implementiert :( )
paths (Node l c r) = [c:current_path | nc <- [l, r], current_path <- paths nc]
-- paths EmptyTree = (-10000, 'b') -- !!!

-- Zählt die schwarzen nodes in einem path
blacklength n (node:path) 
    | snd node == 'b' = blacklength (n+1) path 
    | snd node == 'r' = blacklength n path 
blacklength n node = n 

-- Aufzurufende Funktion, überprüft, ob alle Elemente in blacklist gleich sind
-- blacklist s. nächster Kommentar
validcolour (Node l c r) = all (== head blacklist)  (tail blacklist)
    where 
        -- blacklist ist eine Liste aus den blacklengths der paths
        blacklist = [blacklength 0 t | t <- paths (Node l c r)]
------------------------------------------------------------------------------

------------- "Normale" Implementierung -------------

---- Hilfsfunktionen ----
-- Wenn man von einem el auf den zugehörigen subtree kommen will
-- Allgemein nicht sehr effizient, subtree ist auch relativ groß
-- Abhängig vom Rest der Implementierung könnte auch getNode reichen
getSubtree el (Node l c r)
    | el == c = Node l c r
    | el < c = getSubtree el l 
    | el > c = getSubtree el r

-- get...El gibt (a, Char) zurück
-- Wenn Char == 'n', dann ist etwas schiefgelaufen (sibling existiert nicht,
-- es wurde nach parent von root node gesucht)

-- parent funktioniert, ist aber etwas hässlich und geht viele Fälle durch
-- Alternative: Bei RBTree: Node (RBTree a) (a, Char, parent) (RBTree a)
-- Tatsächliche parent Funktion nur bei insert und Rotationen verwenden
-- vllt selbiges auch für sibling (Noch nicht implementiert :( )

getParentEl el (Node (Node ll l lr) c (Node rl r rr)) 
    | el == l || el == r = c
    | el < c = getParentEl el (Node ll l lr)
    | el > c = getParentEl el (Node rl r rr) 
    | otherwise = (fst c, 'n') -- für root node, entspricht el == c
getParentEl el (Node (Node ll l lr) c EmptyTree)
    | el == l = c
    | el < l = getParentEl el ll
    | el > l = getParentEl el lr
    | otherwise = (fst c, 'n') -- für root node
getParentEl el (Node EmptyTree c (Node rl r rr))
    | el == r = c
    | el < r = getParentEl el rl
    | el > r = getParentEl el rr
    | otherwise = (fst c, 'n') -- für root node
-- Letzter Fall tritt ein, wenn wir bei den leaves landen, oder wenn der Gesamtbaum
-- (Node EmptyTree root EmptyTree) ist
getParentEl el (Node EmptyTree c EmptyTree) = error "el existiert nicht/ist root node"

getGrandparentEl el (Node l c r) = getParentEl (getParentEl el (Node l c r)) (Node l c r)

-- Kann man sich die (Node l c r)s vielleicht sparen?
getSiblingEl el (Node l c r) = getSiblingH el (getSubtree (getParentEl el (Node l c r)) (Node l c r))
    where 
        getSiblingH el (Node (Node ll lc lr) parentc (Node rl rc rr))
            | el == lc = rc 
            | el == rc = lc 
        -- EmptyTree heißt, dass rc bzw. lc gleich el sein muss, da wir in dem parent von el 
        -- sind. Folglich gibt es keinen sibling. 
        getSiblingH el (Node EmptyTree parentc (Node rl rc rr)) = (fst el, 'n') 
        getSiblingH el (Node (Node ll lc lr) parentc EmptyTree) = (fst el, 'n')

getUncleEl el (Node l c r) = getSiblingEl (getParentEl el (Node l c r)) (Node l c r)

rotL EmptyTree

rotR 