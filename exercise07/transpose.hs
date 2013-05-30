hd :: [a] -> [a]
hd []     =  []
hd (x:xs) =  [x]

tl:: [a] -> [[a]]
tl []     = []
tl (x:xs) = [xs]

-- Bind/Sequence
transpose' :: [[a]] -> [[a]]
transpose' []      = []
transpose' ([]:ls) = transpose' ls
transpose' ll      = concat (ll >>= (\l -> return (hd l))) : transpose'' (concat (ll >>= (\l -> return (tl l))))

-- *Main> transpose' [[1,2,3], [4,5,6], [7,8]]
-- [[1,4,7],[2,5,8],[3,6]]

-- do-Notation
transpose'' :: [[a]] -> [[a]]
transpose'' []      = []
transpose'' ([]:ls) = transpose'' ls
transpose'' ll      = concat (do l <- ll; return (hd l)) : transpose' (concat (do l <- ll; return (tl l)))

-- *Main> transpose'' [[1,2,3], [4,5,6], [7,8]]
-- [[1,4,7],[2,5,8],[3,6]]
