module Pirana.Console
where

import System.Console.Haskeline

quit :: InputT IO ()
quit = outputStrLn "goodbye"

handleCmdLine :: String -> InputT IO ()
handleCmdLine cmd = outputStrLn cmd
