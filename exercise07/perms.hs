import Data.List

-- Bind/Sequence
perms' :: Eq a => [a] -> [[a]]
perms' [] = [[]]
perms' l = l >>= (\h -> perms'' (delete h l) >>= (\t -> [h : t]))

-- *Main> perms' [1,2,3]
-- [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

-- do-Notation
perms'' :: Eq a => [a] -> [[a]]
perms'' [] = [[]]
perms'' l = do h <- l; t <- perms'' (delete h l); [h : t]

-- *Main> perms'' [1,2,3]
-- [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
