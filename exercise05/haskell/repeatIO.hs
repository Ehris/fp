repeatIO :: IO Bool -> IO () -> IO ()
repeatIO test oper = do
  a <- test
  oper
  if a == False then
    return ()
  else
    do
      b <- repeatIO test oper
      return b

test = do
  x <- getLine
  if x == "exit" then
    return False
  else
    return True

-- *Main> repeatIO test (putStrLn "next")
-- foo
-- next
-- bar
-- next
-- exit
-- next
