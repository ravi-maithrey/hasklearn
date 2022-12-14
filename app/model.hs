{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Model where

{-# HLINT ignore "Use camelCase" #-}

import Control.Monad.State.Lazy
import GHC.Float (int2Float)

-- how do i genericize a container? instead of list, it can be any container

dot :: [Float] -> [Float] -> Float
dot xs ys = sum $ zipWith (*) xs ys

data Model a = Model {weights :: [a], bias :: a} deriving (Eq, Show)

instance Functor Model where
  fmap f model = model {weights = fmap f (weights model), bias = f (bias model)}

instance Applicative Model where
  pure a = Model {weights = [a], bias = a}
  model1 <*> model2 = Model {weights = zipWith ($) (weights model1) (weights model2), bias = bias model1 $ bias model2}

instance Monad Model where
  model >>= f = model {weights = weight', bias = bias'}
    where
      weight' = concatMap weights (fmap f (weights model))
      bias' = bias $ f (bias model)

-- b = bias model
-- f b = Model b
-- bias (f b) = b'

-- initialize :: [Float] -> [Float] -> Model Float
-- initialize xs ys = Model {weights = replicate (length xs) 0, bias = 0}

xs :: [Float]
xs = [1, 2, 3, 4]

ys :: [Float]
ys = [1, 2, 3, 4]

linearReg :: [Float] -> [Float] -> Model Float
linearReg xs ys = Model {weights = replicate (length xs) 0, bias = 0}

predict :: [Float] -> Model Float -> [Float]
predict xsTe model = fmap (+ b) (zipWith (*) xsTe w)
  where
    w = weights model
    b = bias model

fit :: Model Float -> [Float] -> [Float] -> Model Float
fit model xTrs yTrs = model {weights = updateWeights (weights model) xTrs yTrs, bias = updateBias (bias model) xTrs yTrs}
  where
    updateWeights weights xTr yTr = execState (modifyWeight xTr yTr model) weights
    updateBias bias xTr yTr = execState (modifyBias xTr yTr model) bias

modifyWeight :: MonadState [Float] m => [Float] -> [Float] -> Model Float -> m ()
modifyWeight xTr yTr model = do
  weight <- get
  let dw = -(2 * dot xTr (zipWith (-) yTr (predict xTr model))) / fromIntegral (length xTr)
  let dws = fmap (0.01 *) (replicate (length weight) dw)
  put (zipWith (-) weight dws)

modifyBias :: MonadState Float m => [Float] -> [Float] -> Model Float -> m ()
modifyBias xTr yTr model = do
  bias <- get
  let db = -2 * sum (zipWith (-) yTr (predict xTr model)) / fromIntegral (length xTr)
  put (bias - (0.01 * db))

-- updateWeights weight xTr yTr = execState (State s a) s
-- updateBias biases xTr yTr = undefined

cost :: Model Float -> [Float] -> [Float] -> Float
cost model xs ys = sum (fmap (^ 2) (zipWith (-) ys (predict xs model))) / fromIntegral (length xs)

-- let us assume we have converged if the gradients change less than 0.01%
convergence_threshold :: Float
convergence_threshold = 0.0001

iterations :: Integer
iterations = 10000

-- conver' :: Model Float -> [Float] -> [Float] -> Float -> Model Float
-- conver' model xTrs yTrs change =
--   if change > convergence_threshold
--     then do
--       let model' = fit model xTrs yTrs
--       let change' = abs (bias model - bias model') / bias model'
--       conver' model' xTrs yTrs change'
--     else -- model'
--       model

-- converge :: Model Float -> [Float] -> [Float] -> Model Float
-- converge model xTrs yTrs = conver' model xTrs yTrs 1 -- by giving one we mean we want it to change as we are telling that change% = 100 the first time

converge :: Model Float -> [Float] -> [Float] -> Integer -> Model Float
converge model xTrs yTrs iterations = if iterations < 0 then model else converge (fit model xTrs yTrs) xTrs yTrs (iterations - 1)
