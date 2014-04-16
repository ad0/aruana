{
module PiLexer where

import Pirana.Syntax
}

%wrapper "monad"

tokens :-
  $white+                          ;
  "--".*                           ;
  def                              { tok' TokenDef            }
  end
  0
  \(
  \)
  \+
  \|
  @minIdent
  @majIdent
