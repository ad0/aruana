module ResGraph where

import Data.Graph


type Resource = String

type ResNode = ResNode { allocs :: [Resource]
                       , uses   :: [Resource]
                       , frees  :: [Resource]
                       }

type ResLabeling = Vertex -> ResNode

data ResGraph = ResGraph Graph ResLabeling

