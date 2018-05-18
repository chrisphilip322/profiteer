module Card.Types exposing (..)

type Card =
    Back |
    Front CardFace

type alias CardFace = {
    name: String,
    body: String,
    powerCost: String,
    moneyCost: String,
    pointValue: String
}

