{
module PiParser (parseCommand) where

import Pirana.Syntax
import PiLexer
}

%name parse
%tokentype { Token }
%monad { Alex } { >>= } { return }
%lexer { lexCont } { TokenEOF {} }
%error { parseError }

%token
  'def'                { TokenDef           }
  a_min_ident          { TokenMinIdent _    }
  a_maj_ident          { TokenMajIdent _    }

%left '+'
%right '.'

%%

Command :: 
