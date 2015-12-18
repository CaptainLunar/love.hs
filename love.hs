#!/user/bin/env runhaskell
{-# LANGUAGE RecordWildCards #-}

-- Love.hs ~ lunar muffins
-- A terminal startup application that greets you during login, gives you
-- a fortune, and gives you the current temperature.
--
-- To-do: * Based on the weather, output a message that warns the user as
--          to what they need to wear for the day.
--        * More messages that suggests the user activities for the day based on the weather. 
--          Ex) "It's 70F, isn't it a nice day to ride a bike or go for a walk?"
--
-- Instructions:
--      Make a directory called .lovel in home directory
--      Put love files there.

import System.IO                         
import Net.Weather                        
import System.Environment                
import System.IO.Unsafe
import Data.Random                        
import Data.Random.Source.DevRandom       
import Data.Random.Extras                 
import System.Process
import System.Exit (exitFailure)

-- API Key to weather information.
-- You need to set this in the "myAPIkey file!
mykey :: APIKey
mykey = (head . lines) $ unsafePerformIO $ readFile $ "/home/" ++ userName ++ "/.lovel/myAPIkey.txt"

-- Define variables for state and city.
-- You can set the city and state here before building in cabal.
mycity, mystate :: String
mycity  = "Huntsville"
mystate = "AL"

-- Get the name of this cute person.
userName :: String
userName = let str = unsafePerformIO $ lookupEnv "USER"
               in case str of
                      Nothing -> "Nothing"
                      Just x -> x

-- Greet this person nicely and warmly.
main :: IO ()
main = do
    if userName == "Nothing" then exitFailure else do
        greet <- readFile $ "/home/" ++ userName ++ "/.lovel/lovegreet.txt"
        resp <- getConditions mykey mycity mystate
        msg <- readFile $ "/home/" ++ userName ++ "/.lovel/lovemsg.txt"
        let g = lines greet
            m = lines msg
        putStrLn $ "Hey "++ userName ++ "! " ++ randomGreeting g
        case resp of
            Nothing -> putStrLn $ "Sorry " ++ userName ++ ", I can't find the city or state you're in!"
            Just (Observation{..}) -> do
                putStrLn $ "It is currently " ++ show obsTemp ++ "F and the relative humidity is: " ++ show obsRelHumidity ++ "\n"   
        putStrLn $ "Your fortune for today is as follows:"
        callCommand "fortune"
        putStrLn $ "\nYour love says: " ++ randomGreeting m

-- Helper function that will help us greet this person nicely.
-- Picks a random string from a given list. 
randomGreeting :: [String] -> String
randomGreeting xs = unsafePerformIO $ runRVar (choice xs) DevRandom
