{
module PiLexer where

import Pirana.Syntax
}

%wrapper "monad"

tokens :-
  $white+                          ;
  "--".*                           ;
  def                              { tok' TokenDef            }
  quit                             { tok' TokenQuit           }
  deriv                            { tok' TokenDeriv          }
  local                            { tok' TokenLocal          }
  new                              { tok' TokenNew            }
  end                              { tok' TokenEnd            }
  0                                { tok' TokenEnd            }
  \(                               { tok' TokenLParen         }
  \)                               { tok' TokenRParen         }
  \+                               { tok' TokenPlus           }
  \|                               { tok' TokenPipe           }
  \?                               { tok' TokenQMark          }
  \!                               { tok' TokenEMark          }
  @minIdent                        { tok TokenMinIdent        }
  @majIdent                        { tok TokenMajIdent        }

{

data Token = TokenDef
           | TokenQuit
           | TokenDeriv
           | TokenLocal
           | TokenNew
           | TokenEnd
           | TokenLParen
           | TokenRParen
           | TokenPlus
           | TokenPipe
           | TokenQMark
           | TokenEMark
           | TokenMinIdent String
           | TokenMajIdent String
           | TokenEOF

alexEOF :: Alex Token
alexEOF = return TokenEOF

tok :: (String -> a) -> AlexInput -> Int -> Alex a
tok f loc@(_,_,_input) len = do
  return $ f (take len input)

tok' :: a -> AlexInput -> Int -> Alex a
tok' = tok . const

}
