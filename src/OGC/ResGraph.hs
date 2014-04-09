module OGC.ResGraph where

import Data.Array


type Resource = String

data ResNode = ResNode { resId     :: Int
                       , resAllocs :: [Resource]
                       , resUses   :: [Resource]
                       , resFrees  :: [Resource]
                       }

--data ResGraph = ResGraph Graph ResLabeling

data ResGraph = ResGraph { resNodes :: Array Int ResNode
                         , resTrans :: Array Int [Int]
                         }

