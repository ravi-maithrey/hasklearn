module KNN where

import Data.List
import Data.Ord
import Logistic
import Model

euclideanDistance :: Floating a => [a] -> [a] -> a
euclideanDistance xs ys = sqrt $ sum (fmap (^ 2) (zipWith (-) xs ys))

count :: Ord a => a -> [a] -> Int
count el = length . filter (== el)

specialCompare :: (Ord a, Ord a1) => (a1, a) -> (a1, a) -> Ordering
specialCompare (el1, occ1) (el2, occ2)
  | occ1 < occ2 = LT
  | occ1 > occ2 = GT
  | occ1 == occ2 = compare el1 el2

mostCommon :: Ord a => [a] -> a
mostCommon list = fst $ maximumBy specialCompare [(el, count el list) | el <- list]

xs :: [[Float]]
xs = [[1, 1], [1, 2], [2, 1], [2, 2], [3, 1]]

ys :: [Integer]
ys = [0, 1, 2, 1, 0]

calculateDistance :: (Ord a, Floating a) => [[a]] -> [a] -> [a]
calculateDistance xs new = reverse (sort (fmap (euclideanDistance new) xs))

listFromSecTuple :: [(a, b)] -> [b]
listFromSecTuple = map snd

knn :: Applicative f => f a1 -> f a2 -> f (a1, a2)
knn xs ys = (,) <$> xs <*> ys

knnFit :: [([Float], Integer)] -> [Float] -> Int -> Integer
knnFit combined new k = mostCommon (listFromSecTuple (take k (sortBy (comparing fst) (fmap (\(a, b) -> (euclideanDistance new a, b)) combined))))