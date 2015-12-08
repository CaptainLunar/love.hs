#!/user/bin/env runhaskell
{-# LANGUAGE RecordWildCards #-}
-- Love.hs ~ lunar muffins
-- A terminal startup application that encourages you, the user, 
-- with supportive messages and warm rays of sunshine!

import System.IO                          -- Helps us do wizardy!!!
import Net.Weather                        -- Pretty weather forecast lady.
import System.Environment                 -- Big brother knows all.
import System.IO.Unsafe                   -- Be careful...
import Data.Random                        -- Randomness!
import Data.Random.Source.DevRandom       -- Randomness!!
import Data.Random.Extras                 -- Randomness!!!

-- API Key to weather information.
-- You can literally get this for free though.
mykey :: APIKey
mykey = "0828cc1f268b6c46"

-- Define variables for state and city. 
-- pls be in huntsville
mycity, mystate :: String
mycity  = "Huntsville"
mystate = "AL"

-- Get the name of this cute person.
-- In case of Nothing, don't stress! Default it to any string you want!
userName :: String
userName = let str = unsafePerformIO $ lookupEnv "USER" in
           case str of
               Nothing -> "lunar"
               Just x -> x

-- Greet this person nicely and warmly.
main :: IO ()
main = do
    greet <- readFile $ "/home/" ++ userName ++ "/love/lovegreet.txt"
    resp <- getConditions mykey mycity mystate
    msg <- readFile $ "/home/" ++ userName ++"/love/lovemsg.txt"
    let g = lines greet
        m = lines msg
    putStrLn $ "Hey "++ userName ++ "! " ++ randomGreeting g
    case resp of
        Nothing -> putStrLn $ "Sorry " ++ userName ++ ", I can't find the city or state you're in!"
        Just (Observation{..}) -> do
            putStrLn $ "It is currently " ++ show obsTemp ++ "F and the relative humidity is: " ++ show obsRelHumidity 
    putStrLn $ randomGreeting m

-- Helper function that will help us greet this person nicely.
-- Picks a random string from a given list. 
randomGreeting :: [String] -> String
randomGreeting xs = unsafePerformIO $ runRVar (choice xs) DevRandom
