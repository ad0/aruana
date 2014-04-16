module Pi.Semantics (reductions)
where

import Pi.Syntax

import qualified Data.Set as S

{-
 - The slice semantics is defined with a state of observable names.
 - In this state, a name can be simply observable (a), or has already been escaped from the system (\underline{a}).
 -}

type Obs = Fresh Name
         | Escaped Name

type Names = S.Set Obs

data Derivative
data Reduction

data Action a where
  Opaque      :: Action a
  Open        :: Name -> Action a
  Transparent :: Name -> Action a
  Input       :: Name -> Name -> Action Derivative
  Output      :: Name -> Name -> Action Derivative

data Transition = Transition { transAct :: Action Derivative
                             , transDst :: Process
                             }


derivatives :: Process -> State Names Transition

derivatives Nil = return []

derivatives (Act Tau p)          = return [Transition Opaque p]
derivatives (Act (Input a c) p)  = return [Transition (Input a c) p]
derivatives (Act (Output a c) p) = return [Transition (Output a c) p]

derivatives (Local n p) = undefined

derivatives (New n p) = undefined

derivatives (Sum p q) = liftM2 ++ (derivatives p) (derivatives q)

derivatives (Par p q) = undefined

derivatives (Call k args) = undefined

