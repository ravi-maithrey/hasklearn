import GHC.Float (int2Float)

-- how do i genericize a container? instead of list, it can be any container

dot :: [Float] -> [Float] -> Float
dot xs ys = sum $ pure (*) <*> xs <*> ys

predict :: [Float] -> [Float] -> Float -> [Float]
predict xs w b = fmap (+ b) (pure (*) <*> w <*> xs)

cost :: [Float] -> [Float] -> Float
cost ys hs = sum $ (** 2) <$> (pure (-) <*> ys <*> hs)

-- squaredError :: [Float] -> [Float] -> [Float]
-- squaredError (y:ys) (e:es) = (y-e) ** 2 : squaredError ys es

updateWeights :: [Float] -> [Float] -> [Float] -> [Float] -> [Float]
updateWeights xs hs ys w = fmap (subtract (lr * dw)) w
  where
    dw = (2 * dot xs (pure (-) <*> ys <*> hs)) / int2Float (length ys)
    lr = 0.01

-- dW = - ( 2 * ( self.X.T ).dot( self.Y - Y_pred )  ) / self.m
updateBias :: [Float] -> [Float] -> Float -> Float
updateBias hs ys b = b - (lr * db)
  where
    db = 2.0 * sum (pure (-) <*> ys <*> hs) / int2Float (length ys) -- how to get float from division. convert fractional to float?
    lr = 0.01

-- fit takes xs, ys, initializes weights and biases, updates them
-- predict takes result of fit as weights and biases and xs and gives ys
fit :: [Float] -> [Float] -> ([Float], Float)
fit xs ys = (updateWeights xs hs ys w, updateBias hs ys b)
  where
    w = replicate (length xs) (0 :: Float)
    b = 0 :: Float
    hs = predict xs w b

-- train takes a fit and iterates it. returns us the final weights and biases
