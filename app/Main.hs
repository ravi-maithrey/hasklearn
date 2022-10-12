-- how do i genericize a container? instead of list, it can be any container

dot :: [Float] -> [Float] -> Float
dot (x : xs) (y : ys) = (x * y) : dot xs ys

hypothesis :: [Float] -> [Float] -> Float -> [Float]
hypothesis xs' w b = pure (*) <*> w <*> xs' + b

cost :: [Float] -> [Float] -> Float
cost ys hs = sum $ (** 2) <$> (pure (-) <*> ys <*> hs)

-- squaredError :: [Float] -> [Float] -> [Float]
-- squaredError (y:ys) (e:es) = (y-e) ** 2 : squaredError ys es

updateWeights :: [Float] -> [Float] -> [Float] -> [Float] -> Float -> [Float]
updateWeights xs hs ys w lr = fmap (-(lr * dw)) w
  where
    dw = (2 * dot xs (pure (-) <*> ys <*> hs)) / length xs -- number of training examples. might to change it up in a 2d array?

-- dW = - ( 2 * ( self.X.T ).dot( self.Y - Y_pred )  ) / self.m
updateBias :: [Float] -> [Float] -> [Float] -> Float -> Float -> [Float]
updateBias xs hs ys b lr = fmap (-(lr * db)) b
  where
    db = 2 * sum (pure (-) <*> ys <*> hs) / length xs
