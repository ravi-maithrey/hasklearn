-- how do i genericize a container? instead of list, it can be any container

hypothesis :: [Float] -> Float -> Float -> [Float]
hypothesis xs w b = (b +) <$> fmap (w *) xs

cost :: [Float] -> [Float] -> Float
cost ys hs = sum $ (** 2) <$> (pure (-) <*> ys <*> hs)

-- squaredError :: [Float] -> [Float] -> [Float]
-- squaredError (y:ys) (e:es) = (y-e) ** 2 : squaredError ys es
