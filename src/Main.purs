module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Now (NOW)
import DateDisplay (ui)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

main :: Eff (HA.HalogenEffects (now :: NOW)) Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI ui unit body