-- Input: [a, b, c, d] [(op1), (op2), (op3)] -> op3 ( op2 (op1 (a, b), c), d)

rpn [x] [] = x
rpn [] (x:xs) = error "False input, too many ops"
rpn (x:xs) [] = error "False input, too many els"
rpn (x:y:xs) (op:ops) = rpn ((op x y):xs) ops
rpn (x:xs) (op:ops) = error "False input, op and el count don't match"