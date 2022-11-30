module KNN where

import Logistic
import Model

euclideanDistance :: [Float] -> [Float] -> Float
euclideanDistance xs ys = sqrt $ sum (fmap (^ 2) (zipWith (-) xs ys))

majorityVote :: [a] -> a
majorityVote labels = 