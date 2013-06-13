import BasicParseLib

spotWhile :: (a -> Bool) -> Parse a [a]
spotWhile f = \s -> [(takeWhile f s, dropWhile f s)]

-- *Main> spotWhile (=='a') "aabc"
-- [("aa","bc")]
-- *Main> spotWhile (=='a') "aac"
-- [("aa","c")]
-- *Main> spotWhile (=='a') "aaca"
-- [("aa","ca")]
-- *Main> spotWhile (=='a') ""
-- [("","")]
