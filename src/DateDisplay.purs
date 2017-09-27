module DateDisplay where

import Prelude

import ArmokDate (ArmokDate, ArmokMonth(Granite), convertLocal, showArmokDate)
import Control.Monad.Aff (Aff)
import Control.Monad.Eff.Now (NOW, nowDate)
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE

type State = ArmokDate

data Query a = Regenerate  a

data Input a = Unit

ui :: forall eff. H.Component HH.HTML Query Unit Void (Aff (now :: NOW | eff))
ui =
    H.component
     {
         initialState: const initialState
         , render
         , eval
         , receiver: const Nothing
     }
    where
        initialState :: State
        initialState = { day: 1, month: Granite, year: 0}

        render :: State -> H.ComponentHTML Query
        render state =
            let 
                string = showArmokDate state
            in
                 HH.div_ $ 
                 [ HH.h1_ [ HH.text string ]
                 , HH.button
                   [ HE.onClick (HE.input_ Regenerate) ]
                   [ HH.text "Generate new number" ]
                 ]

        eval :: Query ~> H.ComponentDSL State Query Void (Aff (now :: NOW | eff))
        eval = case _ of
            Regenerate  a -> do
                date <- (H.liftEff nowDate)
                H.put (convertLocal date)
                pure a



























