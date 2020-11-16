import System.Random
import Data.List

guessChecker :: Int -> String -> String -> Char -> IO()
guessChecker n x y guess = do
     if (n >= length x) then (guessF x y) else if (x!!n == guess) then (guessChecker (n+1) x (insertLetter n y guess) guess) else (guessChecker (n+1) x y guess)

     --if (n >= length x) then ("" ++ y) else if (x!!n == guess) then (guessChecker (n+1) x (insertLetter n y guess)) else (guessChecker (n+1) x y)

guessF :: String -> String -> IO()
guessF x y =
	if (x /= y) then
	do
     putStrLn y
     input <- getLine
     let guess = head input
     guessChecker 0 x y guess
     else 
     putStrLn y

printWord :: String -> IO()
printWord x = putStrLn x

makeUnderscore :: Int -> String -> String
makeUnderscore n x = if (n > (length x - 1)) then ("") else ("_" ++ makeUnderscore (n+1) x)

insertLetter :: Int -> String -> Char -> String
insertLetter n word guess = take n word ++ [guess] ++ drop (n+1) word

main :: IO()
main = do 
     content <- readFile "words.txt"
     g <- newStdGen
     let rand = fst $ randomR(0, (length (lines content) - 1)) g
     let word = head $ drop (fromIntegral rand) $ lines content
     let hidden = makeUnderscore 0 word
     --putStrLn hidden
     --input <- getLine
     guessF word hidden
     
     
test :: IO()
test = do
	putStrLn "What is your name?"
	name <- getLine
	putStrLn ("Your name is " ++ name)
