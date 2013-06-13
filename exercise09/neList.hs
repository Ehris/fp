import BasicParseLib

neList :: Parse a b -> Parse a [b]
neList p s = filter (\(n, _) -> case n of
  [] -> False
  l -> True) ((list p) s)

-- *Main> neList (token 'a') "a"
-- [("a","")]
-- *Main> neList (token 'a') ""
-- []
-- *Main> neList (token 'a') "aaabs"
-- [("a","aabs"),("aa","abs"),("aaa","bs")]
