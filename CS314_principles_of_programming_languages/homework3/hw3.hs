import Data.List
myMin = toInteger (minBound::Int)

stupid :: [a] -> Int -> Int -> [a]
stupid x index n = if(index > (length x)) then ([]) else if (mod index n == 0) then ([x!!(index-1)] ++ stupid x (index+1) n) else (stupid x (index+1) n)

skipHelper :: [a] -> Int -> [[a]]
skipHelper x n = if (n > (length x)) then ([[]]) else ([(stupid x 1 n)] ++ (skipHelper x (n+1)))

skips :: [a] -> [[a]]
skips x = take (length x) (skipHelper x 1)

localMaxima :: [Integer] -> [Integer]
localMaxima (prev:all@(current:next:_)) = if (current > prev && current > next) then (current : localMaxima all) else (localMaxima all)
localMaxima _ = []

count :: [Integer] -> Integer -> [Integer]
count _ 10 = []
count x n = [numOccurences x n] ++ count x (n+1)

numOccurences :: [Integer] -> Integer -> Integer
numOccurences [] n = 0
numOccurences (x:xs) n = if (x == n) then (1 + numOccurences xs n) else (numOccurences xs n)

myMax :: [Integer] -> Integer -> Integer
myMax [] n = n
myMax (x:xs) n = if (x > n) then (myMax xs x) else (myMax xs n)

reduceMaxOne :: [Integer] -> Integer -> [Integer]
reduceMaxOne [] max = []
reduceMaxOne (x:xs) max = if (x == max) then ([x-1] ++ reduceMaxOne xs max) else ([x] ++ reduceMaxOne xs max)

doStuff :: [Integer] -> [Integer] -> Integer -> String
doStuff _ _ 0 = "==========\n0123456789\n"
doStuff [] y n = "\n" ++ doStuff (reduceMaxOne y (myMax y myMin)) (reduceMaxOne y (myMax y myMin)) (n-1)
doStuff (x:xs) y n = if (x == n) then ("*" ++ doStuff xs y n) else (" " ++ doStuff xs y n)

histogram :: [Integer] -> String
histogram x = doStuff (count x 0) (count x 0) (myMax (count x 0) myMin)

