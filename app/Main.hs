{-# LANGUAGE FlexibleContexts #-}

import Control.Monad.State.Lazy
import GHC.Float (int2Float)

-- how do i genericize a container? instead of list, it can be any container

dot :: [Float] -> [Float] -> Float
dot xs ys = sum $ zipWith (*) xs ys

-- predict :: [Float] -> [Float] -> Float -> [Float]
-- predict xs w b = fmap (+ b) (zipWith (*) xs w)

-- cost :: [Float] -> [Float] -> Float
-- cost ys hs = sum $ (** 2) <$> zipWith (-) ys hs

-- predict' model xts = model xts

-- linModel = linearRegression xtrs ytrs

-- -- fittedModel = fit linModel

-- linearRegression :: [Float] -> [Float] -> ([Float], Float)
-- linearRegression xtrs ytrs = (execState (updateWeights xtrs ytrs) (replicate (length xtrs) (0 :: Float)), execState (updateBias xtrs ytrs) (0::Float))

-- updateWeights xtrs ytrs = do
--   weights <- get
--   let dw =
-- linearRegression xtrs ytrs =

data Model a = Model {weights :: [a], bias :: a} deriving (Eq, Show)

instance Functor Model where
  fmap f model = model {weights = fmap f (weights model), bias = f (bias model)}

initialize :: [Float] -> [Float] -> Model Float
initialize xs ys = Model {weights = replicate (length xs) 0, bias = 0}

xs :: [Float]
xs = [1, 2, 3, 4]

ys :: [Float]
ys = [1, 2, 3, 4]

linearReg :: [Float] -> [Float] -> Model Float
linearReg = initialize

predict :: [Float] -> Model Float -> [Float]
predict xsTe model = fmap (+ b) (zipWith (*) xs w)
  where
    w = weights model
    b = bias model

fit :: Model Float -> [Float] -> [Float] -> Model Float
fit model xTrs yTrs = model {weights = updateWeights (weights model) xTrs yTrs, bias = updateBias (bias model) xTrs yTrs}
  where
    updateWeights weight xTr yTr = execState (modifyWeight xTr yTr model) weight
    updateBias bias xTr yTr = execState (modifyBias xTr yTr model) bias

modifyWeight xTr yTr model = do
  weight <- get
  let dw = -(2 * dot xTr (zipWith (-) yTr (predict xTr model))) / fromIntegral (length xTr)
  put (weight - (0.01 * dw))

modifyBias xTr yTr model = do
  bias <- get
  let db = -2 * sum (zipWith (-) yTr (predict xTr model)) / fromIntegral (length xTr)
  put (bias - (0.01 * db))

-- updateWeights weight xTr yTr = execState (State s a) s
-- updateBias biases xTr yTr = undefined

cost :: Model Float -> [Float] -> [Float] -> Float
cost model xs ys = sum (fmap (^ 2) (zipWith (-) ys (predict xs model))) / fromIntegral (length xs)