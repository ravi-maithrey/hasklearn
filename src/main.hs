-- how do i genericize a container? instead of list, it can be any container

dot :: [Float] -> [Float] -> Float
dot (x : xs) (y : ys) = (x * y) : dot xs ys

hypothesis :: [Float] -> [Float] -> Float -> [Float]
hypothesis xs w b = pure (*) <*> w <*> xs

cost :: [Float] -> [Float] -> Float
cost ys hs = sum $ (** 2) <$> (pure (-) <*> ys <*> hs)

-- squaredError :: [Float] -> [Float] -> [Float]
-- squaredError (y:ys) (e:es) = (y-e) ** 2 : squaredError ys es

updateWeights :: [Float] -> [Float] -> [Float] -> [Float] -> Float -> [Float]
updateWeights xs hs ys w lr = fmap (-(lr * dw)) w
  where
    dw = dot xs (pure (-) <*> ys <*> hs)

-- dW = - ( 2 * ( self.X.T ).dot( self.Y - Y_pred )  ) / self.m
