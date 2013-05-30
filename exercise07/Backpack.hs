import Data.List

type Name       = String
type Weight     = Integer
type Item       = (String, Weight)
type ItemList   = [Item]
type CurrWeight = Integer
type MaxWeight  = Integer
type Content    = (ItemList, CurrWeight, MaxWeight)

data Backpack a = Tatters | Backpack a deriving (Show)

backpack = Backpack ([], 0, 100)

instance Monad (Backpack) where
  Tatters >>= k    = Tatters
  Backpack x >>= k = k x
  return           = Backpack

-- store, remove  :: ... -> Backpack Content
store :: Item -> Content -> Backpack Content
store (i,w) (l,c,m) = do
  if c + w > m then
    Tatters
  else
    return (((i,w):l), c + w, m)

remove :: Item -> Content -> Backpack Content
remove (i,w) (l,c,m) = do
  if c - w < 0 then
    Tatters
  else
    return (delete (i,w) l, c - w, m)

pack :: [Content -> Backpack Content] -> Backpack Content -> Backpack Content
pack [] b = b
pack (x:xs) b = do
  c <- b
  pack xs (x c)

-- *Main> backpack >>= store ("Buch", 1) >>= remove ("Buch", 1) >>= store ("Schrank", 100)
-- Backpack ([("Schrank",100)],100,100)
-- *Main> backpack >>= store ("Steinsammlung", 101) >>= remove ("Steinsammlung", 101)
-- Tatters
-- *Main> pack [store ("Buch", 1), remove ("Buch", 1), store ("Schrank", 100)] backpack
-- Backpack ([("Schrank",100)],100,100)
