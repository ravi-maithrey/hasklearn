module Logistic where

import Model

sigmoid :: Float -> Float
sigmoid x = 1 / (1 + exp (-x))

predictLogit :: Model Float -> [Float] -> [Float]

preditLogit model xsTe = sigmoid <$> fmap (+ b) (zipWith (*) xsTe w)
  where
    w = weights model
    b = bias model

negLogLikelihood ys ysTrue
