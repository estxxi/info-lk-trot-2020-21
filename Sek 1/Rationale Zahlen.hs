newtype Rat = R(Int,Int)
instance Show Rat where
	show (R(z,n)) = show z ++ "/" ++ show n
	
mul :: Rat -> Rat -> Rat
mul (R(a,b)) (R(c,d)) = (R(a*c,b*d)) 

--add1 :: Rat -> Rat -> Rat
--add1 (R(a,b)) (R(c,d)) = if b==d then (R(a+c,b)) otherwise (R(a*d+c*b,d*b))

norm :: Rat -> Rat 
norm (R(z,n)) = R((vorz*z'),n')
	where
		z' = div (abs z) t 
		t  = ggt (abs z) (abs n) 
		n' = div (abs n) t
		vorz = signum (n*z)


ggt :: Int -> Int -> Int
ggt a b  | a>b = ggt b a
		 | a==0 = b
		 |otherwise = ggt (b `mod` a) a
		 
betrag :: Rat -> Rat 
betrag (R(a,b)) | a<0 = (R(a*(-1),b)) 
				|otherwise = (R(a,b))
				
neg :: Rat -> Rat 
neg (R(a,b)) = (R(a*(-1),b))

sub :: Rat -> Rat -> Rat
sub (R(a,b)) (R(c,d)) | b==d = (R(a-c,b))
					  |otherwise = (R(a*d-c*b,d*b))

