module Main where

factorial :: Integer -> Integer
factorial n =
    if n == 0 
        then 1 
        else n * factorial (n - 1)

main :: IO ()
main = do 
    input <- getLine
    let cleanInput = filter (/= '!') input
    print(factorial (read cleanInput :: Integer))
