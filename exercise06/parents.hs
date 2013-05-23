import Sheep
import Data.Maybe
import Control.Monad

parents :: Int -> Sheep -> Maybe Sheep
parents 0 sheep = Just sheep
parents n sheep = if isJust( do
  m <- mother sheep
  parents (n - 1) m
  ) then do
      mo <- mother sheep
      parents (n - 1) mo
    else do
      fa <- father sheep
      parents (n - 1) fa

-- parents' :: Int -> Sheep -> [Sheep]
-- parents' 0 sheep = [sheep]
-- parents' n sheep =
--   if isJust (mother sheep) then
--     if isJust (father sheep) then
--       (maybeToList (mother sheep) >>= (\x -> parents' (n - 1) x)) ++ (maybeToList (father sheep) >>= (\x -> parents' (n - 1) x))
--     else
--       maybeToList (mother sheep) >>= (\x -> parents' (n - 1) x)
--   else
--     if isJust (father sheep) then
--       maybeToList (father sheep) >>= (\x -> parents' (n - 1) x)
--     else
--       []

parents' :: Int -> Sheep -> [Sheep]
parents' 0 sheep = [sheep]
parents' n sheep = do
  (maybeToList (mother sheep) >>= parents' (n - 1)) ++ (maybeToList (father sheep) >>= parents' (n - 1))