module Logistic where

import Model

sigmoid :: Float -> Float
sigmoid x = 1 / (1 + exp (-x))

predictLogit :: Model Float -> [Float] -> [Float]

preditLogit model xsTe = fmap sigmoid (dot xsTe w + b)
