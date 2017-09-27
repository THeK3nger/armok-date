module ArmokDate where

import Prelude

import Data.Date (Date, Month(March), canonicalDate, day, diff, year)
import Data.Enum (fromEnum, toEnum)
import Data.Int (floor)
import Data.Maybe (Maybe(..), fromJust, fromMaybe')
import Data.Time.Duration (Days(Days))
import Partial.Unsafe (unsafePartial)

data ArmokMonth = Granite | Slate | Felsite | Hematite | Malachite 
    | Galena | Limestone | Sandstone | Timber | Moonstone | Opal
    | Obsidian

type ArmokDate = { day :: Int , month :: ArmokMonth, year :: Int }

-- Number of days since the last 21th March
march21 :: Date -> Days
march21 d = 
    let th21 = fromMaybe' (\_ -> (day d)) (toEnum 21) -- I'm sure this is not Nothing. But I don't know how to force this cause not Partial
        m21 = canonicalDate  (year d)  (March) th21 in 
            diff d m21

computeDay :: Days -> Int
computeDay (Days s) | s > 0.0 = (mod (floor (s * 365.25 / 336.0)) 28) + 1
computeDay (Days s) = (mod (floor ((s+365.0) * 365.25 / 336.0)) 28) + 1

computeMonth :: Days -> Int
computeMonth (Days s) | s > 0.0 = (div (floor (s * 365.25 / 336.0)) 28) + 1
computeMonth (Days s) = (div (floor ((s+365.0) * 365.25 / 336.0)) 28) + 1

toAmrokMonth :: Int -> Maybe ArmokMonth
toAmrokMonth 1 = Just Granite
toAmrokMonth 2 = Just Slate
toAmrokMonth 3 = Just Felsite
toAmrokMonth 4 = Just Hematite
toAmrokMonth 5 = Just Malachite
toAmrokMonth 6 = Just Galena
toAmrokMonth 7 = Just Limestone
toAmrokMonth 8 = Just Sandstone
toAmrokMonth 9 = Just Timber
toAmrokMonth 10 = Just Moonstone
toAmrokMonth 11 = Just Opal
toAmrokMonth 12 = Just Obsidian
toAmrokMonth _ = Nothing

convert :: Date -> ArmokDate
convert earthdate = { day: d, month: m, year: y}
    where
        delta = march21 earthdate
        d = computeDay delta
        m = unsafePartial (fromJust ((toAmrokMonth <<< computeMonth) delta))
        y = (fromEnum (year earthdate)) - 2006

showArmokMonth :: ArmokMonth -> String
showArmokMonth Granite = "Granite"
showArmokMonth Slate = "Slate"
showArmokMonth Felsite = "Felsite"
showArmokMonth Hematite = "Hematite"
showArmokMonth Malachite = "Malachite"
showArmokMonth Galena = "Galena"
showArmokMonth Limestone = "Limestone"
showArmokMonth Sandstone = "Sandstone"
showArmokMonth Timber = "Timber"
showArmokMonth Moonstone = "Moonstone"
showArmokMonth Opal = "Opal"
showArmokMonth Obsidian = "Obsidian"

daySuffix :: Int -> String
daySuffix 1 = "st"
daySuffix 2 = "nd"
daySuffix 3 = "rd"
daySuffix _ = "th"

showArmokDate :: ArmokDate -> String
showArmokDate date = (show date.day) <> (daySuffix date.day) <> " " <> showArmokMonth(date.month) <> ", " <> (show date.year)




































