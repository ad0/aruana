module Main where

import System.Console.Haskeline
import Pirana.Console


main :: IO ()
main = runInputT defaultSettings loop
  where loop :: InputT IO ()
        loop = do
          maybeLine <- getInputLine "pi> "
          case maybeLine of
            Nothing  -> quit
            Just cmd -> do handleCmdLine cmd ; loop
