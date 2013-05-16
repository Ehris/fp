accumulateIO :: [IO a] -> IO [a]
accumulateIO [] = do
  return []
accumulateIO (x:xs) = do
  result <- x
  list <- accumulateIO xs
  return (result:list)

-- *Main> accumulateIO [getLine, getLine]
-- foo
-- bar
-- ["foo","bar"]

sequenceIO :: [IO a] -> IO ()
sequenceIO [] = do
  return ()
sequenceIO (x:xs) = do
  result <- x
  sequenceIO xs

-- *Main> sequenceIO [putStrLn "foo", putStrLn "bar"]
-- foo
-- bar

seqList :: [a -> IO a] -> a -> IO a
seqList [] arg = do
  return arg
seqList (x:xs) arg = do
  result <- x arg
  seqList xs result

addfoo x = do
  return (x++"foo")

-- *Main> seqList [addfoo, addfoo, addfoo, addfoo, addfoo] "bar"
-- "barfoofoofoofoofoo"
