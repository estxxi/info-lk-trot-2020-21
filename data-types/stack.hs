-- Stack als algebraischer Datentyp
data Stack a = EmptyStack | Node a (Stack a) deriving Show

emptyStack = EmptyStack

isEmptyStack EmptyStack = True
isEmptyStack (Node x xs) = False

pushStack x xs = (Node x xs)

popStack EmptyStack  = error "popStack: empty arg"
popStack (Node x xs) = xs

topStack EmptyStack          = error "popStack: empty arg"
topStack (Node x xs)         = x

-- Stack als Liste
l_emptyStack = []

l_isEmptyStack [] = True
l_isEmptyStack (x:xs) = False

l_popStack xs = l_popStackHelp xs (l_isEmptyStack xs)
          where l_popStackHelp xs True = error "popFct: Empty arg"
                l_popStackHelp (x:xs) False = xs

l_pushStack x xs = l_pushStackHelp x xs (l_isEmptyStack xs)
             where l_pushStackHelp x xs True = [x]
                   l_pushStackHelp x xs False = (x:xs)

l_topStack xs = l_topStackHelp xs (l_isEmptyStack xs)
          where l_topStackHelp xs True = error "topFct: Empty arg"
                l_topStackHelp (x:xs) False = x