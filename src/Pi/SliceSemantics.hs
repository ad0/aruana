module Pi.Semantics (reductions)
where

import Pi.Syntax

data SAction = SReduct Name
             | SInput Name Name
             | SOutput Name Name

data Transition = Transition { transAction :: SAction
                             , transCont   :: Process
                             }

data SReduction = Opaque
                | Open Name
                | Transparent Name

data Reduction = Reduction { redCont :: Process }


derivatives :: Process -> Reader [Def] [Transition]
derivatives = undefined

reductions :: Process -> Reader [Def] [Reduction]
reductions = undefined
