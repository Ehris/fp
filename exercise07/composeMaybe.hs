composeMaybe' a b c = do
  x <- b c
  a x
  
composeMaybe :: (a -> Maybe b) -> (b -> Maybe c) ->  (a -> Maybe c)
composeMaybe a b = composeMaybe' b a

f a b = if (a b) then Just b else Nothing

-- *Main> composeMaybe (f (>=3)) (f (<7)) 1
-- Nothing
-- *Main> composeMaybe (f (>=3)) (f (<7)) 7
-- Nothing
-- *Main> composeMaybe (f (>=3)) (f (<7)) 6
-- Just 6
-- *Main> composeMaybe (f (>=3)) (f (<7)) 5
-- Just 5
-- *Main> composeMaybe (f (>=3)) (f (<7)) 4
-- Just 4
-- *Main> composeMaybe (f (>=3)) (f (<7)) 3
-- Just 3
-- *Main> composeMaybe (f (>=3)) (f (<7)) 2
-- Nothing
