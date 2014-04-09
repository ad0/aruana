module Pi.Syntax where

type Name = String

data Action = Tau
            | Input Name Name
            | Output Name Name
            deriving (Eq, Show)

data Process = Nil
             | Act Action Process
             | Local Name Process
             | New Name Process
             | Par Process Process
             | Sum Process Process
             | Call String [Name]
             deriving (Eq, Show)

data Def = Def { defName   :: String
               , defParams :: [Name]
               , defBody   :: Process
               }
               deriving (Eq, Show)

data Script = Script { scriptDefs :: [Def]
                     , scriptMain :: Process
                     }
                     deriving (Eq, Show)




