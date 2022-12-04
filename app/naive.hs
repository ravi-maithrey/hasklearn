module Naive where

import Data.List

data Data a = Data {input :: [a], output :: a} deriving (Eq, Show)

-- instance Functor Data where
--   fmap f datas = datas {input = fmap f (input datas), output = output datas}

-- this is the smoothing factor
k :: Integer
k = 1

datas :: [Data Float]
datas = [Data {input = [1, 2, 3], output = 0}, Data {input = [1, 2, 1], output = 1}, Data {input = [1, 2, 2], output = 1}, Data {input = [2, 2, 3], output = 0}]

-- gives us total number of 0s and 1s
countClasses :: [Data Float] -> (Integer, Integer)
countClasses datas = (sum (fmap (\a -> if a == 0 then 1 else 0) (output <$> datas)), sum $ fmap (\a -> if a == 1 then 1 else 0) (output <$> datas))

orderData :: [Data Float] -> [Float]
orderData datas = nub $ sort (concatMap input datas)

checkDatas :: [Data Float] -> [Float]
checkDatas datas = fromIntegral . length <$> (group . sort) (concatMap input datas)

-- takes each value in ordered data and its's count and give total product probabilities this is p_x
probDatas :: [Data Float] -> Float
probDatas datas = product ((/ sum total) <$> total)
  where
    total = checkDatas datas

-- probDataZero :: [Data Float] -> Float
-- probDataZero datas =

test datas a = (\(x : xs) a -> if a elem (input x) && (output x) == 0 then 1 else 0) datas a