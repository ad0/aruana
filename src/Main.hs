module Main where

import System.Environment
import System.Exit

main :: IO ()
main = getArgs >>= parseArgs >>= analyze

analyze :: [String] -> IO ()
--analyze (r:rs) = analyzeResModel r >> analyzeResModel rs
--  where analyzeResModel res = case parseResModel res of
--                              Left  rg -> putStrLn ("error: " ++ e)
--                              Right _  -> putStrLn "."
analyze (_:_) = putStrLn "parser not yet implemented" >> die
analyze [] = return ()

parseArgs :: [String] -> IO [String]
parseArgs ["-h"] = usage   >> exit
parseArgs ["-v"] = version >> exit
parseArgs []     = sequence [getContents]
parseArgs fs     = mapM readFile fs

usage :: IO ()
usage = putStrLn "Usage: aruana [-vh] [file ...]"

version :: IO ()
version = putStrLn "Aruana 0.1"

exit :: IO a
exit = exitWith ExitSuccess

die :: IO a
die = exitWith (ExitFailure 1)
