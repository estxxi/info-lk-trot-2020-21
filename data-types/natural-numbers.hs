data Nat = Null | Suc Nat deriving Show

plus :: Nat -> Nat -> Nat
plus Null x = x
plus x Null = x
plus (Suc x) y = Suc (plus x y) 

minus :: Nat -> Nat -> Nat
minus x Null = x
minus Null y = error "Were nat"
minus (Suc x) (Suc y) = minus x y

times :: Nat -> Nat -> Nat
times x Null = Null
times x (Suc Null) = x
times x (Suc y) = plus x (times x y)

quotient :: Nat -> Nat -> Nat
quotient x Null = error "Zero div"
quotient Null y = Null
quotient x y = plus (Suc Null) (quotient (minus x y) y)