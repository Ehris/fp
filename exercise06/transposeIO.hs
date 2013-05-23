import System.IO
import Data.List
import Data.Function

transposeStr :: [String] -> [String]
transposeStr list =
  let len = length (maximumBy (compare `on` length) list) in
    map j (transpose (map (\ x -> sp (x ++ (s (len - (length x))))) list))
  where
    j l = foldl (++) "" l
    s n = j (take n (repeat " "))
    sp "" = []
    sp (x:l) = [x] : (sp l)

transposeIO :: FilePath -> FilePath -> IO ()
transposeIO s d = do
  list <- getLines s
  let output = unlines (transposeStr list)
  writeFile d output
  where
    getLines path = do
      contents <- readFile path
      return (lines contents)

test = transposeIO "trans.txt" "trans2.txt"
