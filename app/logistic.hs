{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MonoLocalBinds #-}

module Logistic where

import Control.Monad.State.Lazy
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

learningRate :: Float
learningRate = 0.01

-- total cost is averaged loss
logisticCost :: [Float] -> [Float] -> Float
logisticCost ysPred ysTrue = (sum $ zipWith logisticLoss ysPred ysTrue) / fromIntegral (length ysPred)

logisticRegression :: [Float] -> [Float] -> Model Float
logisticRegression xs ys = Model {weights = replicate (length xs) 0, bias = 0}

modifyLogWeight xTrs yTrs model = do
  weight <- get
  let change = zipWith (-) (predictLogit model xTrs) yTrs
  let dw = fmap (* (1 / fromIntegral (length xTrs))) (zipWith (*) change xTrs)
  let dws = fmap (0.01 *) dw
  put (zipWith (-) weight dws)

-- modifyBiasxTrs yTrs model = do
--   bias <- get
--   let change = zipWith (-) (predictLogit model xTrs) yTrs

fitLogistic :: Model Float -> [Float] -> [Float] -> Model Float
fitLogistic model xsTr ysTr = model {weights = updateWeights (weights model) xsTr ysTr, bias = bias model}
  where
    updateWeights weight xs ys = execState (modifyLogWeight xs ys model) weight

iterations :: Integer
iterations = 5000

convergeLogistic :: Model Float -> [Float] -> [Float] -> Integer -> Model Float
convergeLogistic model xTrs yTrs iterations = if iterations < 0 then model else convergeLogistic (fitLogistic model xTrs yTrs) xTrs yTrs (iterations - 1)