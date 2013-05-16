takeWhileIO :: (a -> Bool) -> IO a -> IO [a]
takeWhileIO pred oper = do
  a <- oper
  let b = pred a
  if b == False then
    return []
  else
    do
      c <- takeWhileIO pred oper
      return (a:c)

-- *Main> takeWhileIO (\x -> if x == "exit" then False else True) getLine
-- foo
-- bar
-- exit
-- ["foo","bar"]
