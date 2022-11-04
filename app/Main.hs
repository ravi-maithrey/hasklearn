{-# LANGUAGE FlexibleContexts #-}

import Control.Monad.State.Lazy
import GHC.Float (int2Float)

-- how do i genericize a container? instead of list, it can be any container

dot :: [Float] -> [Float] -> Float
dot xs ys = sum $ zipWith (*) xs ys

predict :: [Float] -> [Float] -> Float -> [Float]
predict xs w b = fmap (+ b) (zipWith (*) xs w)

cost :: [Float] -> [Float] -> Float
cost ys hs = sum $ (** 2) <$> zipWith (-) ys hs

predict' model xts = model xts

linModel = linearRegression xtrs ytrs

-- fittedModel = fit linModel

linearRegression :: [Float] -> [Float] -> ([Float], Float)
linearRegression xtrs ytrs = (execState (updateWeights xtrs ytrs) (replicate (length xtrs) (0 :: Float)), execState (updateBias xtrs ytrs) (0::Float))

updateWeights xtrs ytrs = do
  weights <- get
  let dw = 
-- linearRegression xtrs ytrs = 