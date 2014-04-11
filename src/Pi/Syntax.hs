module Pi.Syntax where

import Control.Monad.Reader
import qualified Data.Set as Set


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


unfold :: Process -> Reader [Def] Process

unfold p@Nil = return p

unfold p@(Act _ _) = return p

unfold (Local n p) = undefined

unfold (New n p) = undefined

unfold (Par p q) = do
  p' <- unfold p
  q' <- unfold q
  return $ Par p' q'

unfold (Sum p q) = do
  p' <- unfold p
  q' <- unfold q
  return $ Sum p' q'

unfold (Call k args) = undefined
