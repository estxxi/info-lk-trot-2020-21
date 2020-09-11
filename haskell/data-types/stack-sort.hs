-- Sortieren eines Stacks unter Benutzung von Stack Operationen
-- Stack über Listen für einfachere Syntax implemetiert


-- Stack-Implementierung:
emptyStack = []

isEmptyStack [] = True
isEmptyStack (x:xs) = False

popStack xs = popStackHelp xs (isEmptyStack xs)
        where popStackHelp xs True = error "popFct: Empty arg"
              popStackHelp (x:xs) False = xs

pushStack x xs = pushStackHelp x xs (isEmptyStack xs)
           where pushStackHelp x xs True = [x]
                 pushStackHelp x xs False = (x:xs)

topStack xs = topStackHelp xs (isEmptyStack xs)
        where topStackHelp xs True = error "topFct: Empty arg"
              topStackHelp (x:xs) False = x

reverseStack xs = reverseStackHelp xs []
            where reverseStackHelp [] out = out
                  reverseStackHelp xs out = reverseStackHelp (popStack xs) (pushStack (topStack xs) out)


-- Sortierung:
-- Ziel: Stack xs (beliebige Stack, fin muss eine Teilmenge sein) soll durch n Schritte,
-- also Stackoperationen, zu fin "umgeformt" werden, die Schrittzahl soll ausgegeben werden.
-- Die Stackoperationen in reverseStack werden nicht gezählt.
listgenStack xs fin = listgenStackHelp xs [] [] (reverseStack fin) 0
    -- xs: "Hauptstack"; med: Ausgabestack, soll fin vom Anfang erreichen; 
    -- inter: Zwischenspeicher für Stackelemente; step: Schrittzahl
    where listgenStackHelp xs med inter fin step 
                                           -- Ausgabeschritt, Abbruchbedingung ist der leere Zielstack
                                           | fin == [] = (med, step) 
                                           -- Wenn der Hauptstack durchgegangen wurde, wird unser Zwischenspeicher zur neuen Ausgangsliste; +1 Schritt
                                           | isEmptyStack xs = listgenStackHelp inter med [] fin (step + 1)
                                           -- Wenn das oberste Element unseres Hauptstacks mit dem obersten Element der umgekehrten Zielliste übereinstimmt,
                                           -- wird dieses oben auf unsere Ausgabeliste "med" gelegt und von unserem Hauptstack und der Zielliste oben entfernt
                                           -- +3 Stackoperationen (2x pop, 1x push)
                                           | topStack xs == topStack fin = listgenStackHelp (popStack xs) (pushStack (topStack xs) med) inter (popStack fin) (step + 3)
                                           -- Wenn das oberste Element unseres Hauptstacks mit dem obersten Element der umgekehrten Zielliste nicht übereinstimmt,
                                           -- wird das Element auf den Zwischenspeicher geschoben, also von unserem Hauptstack entfernt und auf den Zwischenspeicher
                                           -- gepusht; +2 Stackoperationen (1x pop, 1x push)
                                           | topStack xs /= topStack fin = listgenStackHelp (popStack xs) med (pushStack (topStack xs) inter) fin (step + 2)
