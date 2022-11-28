module Logistic where

import Model

sigmoid :: Float -> Float
sigmoid x = 1 / (1 + exp (-x))

predictLogit :: Model Float -> [Float] -> [Float]
predictLogit model xsTe = sigmoid <$> fmap (+ b) (zipWith (*) xsTe w)
  where
    w = weights model
    b = bias model

logisticLoss :: Float -> Float -> Float
logisticLoss ypred yTrue = -((yTrue * log ypred) + ((1 - yTrue) * log (1 - ypred)))

-- total cost is averaged loss
logisticCost :: [Float] -> [Float] -> Float
logisticCost ysPred ysTrue = sum $ zipWith logisticLoss ysPred ysTrue
