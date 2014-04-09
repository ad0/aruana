module Pi.PrettyPrinter (PrettyPrintable (..)) where

import Pi.Syntax

import Text.PrettyPrint


class PrettyPrintable a where
  prettyPrint :: a -> String


ppAction :: Action -> Doc
ppAction Tau = text "tau"
ppAction (Input c x) = text c <> char '?' <> char '(' <> text x <> char ')'
ppAction (Output c x) = text c <> char '!' <> text x

instance PrettyPrintable Action where
  prettyPrint = render . ppAction


ppProcess :: Process -> Doc
ppProcess Nil = char '0'
ppProcess (Act a p) = ppAction a <> char '.' <$> ppProcess p
ppProcess (Local n p) = text "local" <> char '(' <> text n <> char ')' <$>
                        char '(' <> ppProcess p <> char ')'
ppProcess (New n p) = text "new" <> char '(' <> text n <> char ')' <$>
                      char '(' <> ppProcess p <> char ')'
ppProcess (Par p q) = char '(' <> ppProcess p <+> char '|' <+> ppProcess q <> char ')'
ppProcess (Sum p q) = char '(' <> ppProcess p <+> char '+' <+> ppProcess q <> char ')'
ppProcess (Call k as) = text k <> char '(' <> argsDoc <> char ')'
  where argsDoc = punctuate (text ", ") $ map text as

instance PrettyPrintable Process where
  prettyPrint = render . ppProcess


ppDef :: Def -> Doc
ppDef = error "ppDef not yet implemented"

instance PrettyPrintable Def where
  prettyPrint = render . ppDef


ppScript :: Script -> Doc
ppScript = error "ppScript not yet implemented"

instance PrettyPrintable Script where
  prettyPrint = render . ppScript

