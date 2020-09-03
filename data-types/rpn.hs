rpn [x] [] = x
rpn [] (x:xs) = error "Op stack not empty"
rpn (x:y:xs) [] = error "Val stack not empty"
rpn (x:y:xs) op:ops = rpn ((op x y):xs) ops