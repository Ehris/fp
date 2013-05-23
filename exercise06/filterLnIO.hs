import System.IO
import Data.List

filterLn :: (String -> Bool) -> [String] -> [String]
filterLn p s = reverse $ f p s [] 1
  where
    f _ []    x y = (("Hits: " ++ (show (length x)) ++ ", percentage: " ++ (show ((fromIntegral (length x) :: Double) / (fromIntegral y :: Double)))) : ("" : x))
    f p [s]   x y | p s  = f p [] (("Z " ++ (show y) ++ ": " ++ s) : x) y
                  | True = f p [] x y
    f p (s:r) x y | p s  = f p r (("Z " ++ (show y) ++ ": " ++ s) : x) (y + 1)
                  | True = f p r x (y + 1)

filterLnIO :: (String -> Bool) -> FilePath -> FilePath -> IO ()
filterLnIO p s d = do
  list <- getLines s
  let output = unlines (filterLn p list)
  writeFile d output
  where
    getLines path = do
      contents <- readFile path
      return (lines contents)

test = filterLnIO (isInfixOf "e") "test.txt" "test2.txt"
