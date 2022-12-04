module Naive where

data Data a = Data {input :: [a], output :: a}

instance Functor Data a where
  fmap f data = data {input = fmap f (input data), output = output data}