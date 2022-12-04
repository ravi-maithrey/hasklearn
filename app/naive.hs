module Naive where

data Data a = Data {input :: [a], output :: a}

-- instance Functor Data where
--   fmap f datas = datas {input = fmap f (input datas), output = output datas}

-- this is the smoothing factor
k = 1

countClasses :: [Data a] -> (Integer, Integer)
countClasses datas = (fmap (\a -> if a == 0 then 1 else 0) (output <$> datas), fmap (\a -> if a == 1 then 1 else 0) (output <$> datas))