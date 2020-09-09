
--Typklassen
--Num a Int, Intenger, Float, Double
--funktionsname :: Num a => a -> [a] -> [a]


--Show a 	Typ zu String

--Read a	String zu Typ

--Eq a  	==, /=

--Ord a 	<, >, >=, <=, ==, /=

--Enum a	Aufzählung

--Bunded a  Minimun, Maximum


--mit type wird Typsynonym festgelegt
--Adresse kann mit Namen vertauscht werden
type Name = String
type Nummer = Int
type Ort = String
type Adresse = (Name, Ort, Nummer) 

eintragA, eintragB:: Adresse
eintragA= ("Klaus","Berlin",1234)
eintragB=("Susi","München",5678)
eintragC=("Strolch","Wupertal",123)

gleicherOrt::Adresse->Adresse->Bool
gleicherOrt (a,b,c) (d,e,f) = b==e 


--newtype baut einen eigenen Datentypen
newtype Name2 = N String -- N ist ein Konstruktor
    deriving Show --Name2 gehört zur Typklasse Show

newtype Ort2 = O String -- O auch
instance Show Ort2 where -- in der Typklasse Show
    show (O ort) = "Ort:" ++ (show ort) -- wird neue show-fkt instanziert

name1 = N "Klaus"
ort1 = O "Berlin"
