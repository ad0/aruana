module Pi.Syntax where

import Data.Set


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

freeNames :: Process -> Set.Set Name
freeNames Nil = Set.empty
freeNames (Act Tau p) = freeNames p
freeNames (Act (Input c x) p) = Set.insert c $ Set.delete x $ freeNames p
freeNames (Act (Output c x) p) = Set.insert c $ Set.insert x $ freeNames p
freeNames (Local n p) = Set.delete n $ freeNames p
freeNames (New n p) = Set.delete n $ freeNames p
freeNames (Par p q) = freeNames p `Set.union` freeNames q
freeNames (Sum p q) = freeNames p `Set.union` freeNames q
freeNames (Call _ as) = Set.fromList as

unfold :: Reader [Def] Process -> Reader [Def] Process
unfold = error "unfold not yet implemented"

