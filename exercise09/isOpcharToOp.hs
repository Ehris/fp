import BasicParseLib

isOp :: Char -> Bool
isOp c =
  case c of
    '+' -> True
    '-' -> True
    '*' -> True
    '/' -> True
    '%' -> True
    _   -> False

charToOp :: Char -> Ops
charToOp c =
  case c of
    '+' -> Add
    '-' -> Sub
    '*' -> Mul
    '/' -> Div
    '%' -> Mod

-- *Main> charToOp '+'
-- Add
-- *Main> charToOp '#'
-- *** Exception: isOpcharToOp.hs:(15,3)-(20,14): Non-exhaustive patterns in case
--
-- *Main> charToOp '+'
-- Add
-- *Main> charToOp '-'
-- Sub