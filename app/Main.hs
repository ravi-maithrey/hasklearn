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

linearReg :: Model Float
linearReg = initialize xs ys

predict :: [Float] -> Model Float -> [Float]
predict xsTe model = fmap (+ b) (zipWith (*) xs w)
  where
    w = weights model
    b = bias model

fit :: Model Float -> [Float] -> [Float] -> Model Float
fit model xTrs yTrs = model {weights = updateWeights (weights model) xTrs yTrs, bias = updateBias (bias model) xTrs yTrs}

updateWeights = undefined

updateBias = undefined