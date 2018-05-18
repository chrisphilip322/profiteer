module Card.Decode exposing (..)

import Card.Types exposing (Card(..), CardFace)

import Json.Decode exposing (Decoder, andThen, succeed, map5, string)

cardDecoder : Decoder Card
cardDecoder =
    let
        convert : CardFace -> Decoder Card
        convert raw =
            succeed (Front raw)
    in
        cardFaceDecoder |> andThen convert

cardFaceDecoder : Decoder CardFace
cardFaceDecoder =
    Json.Decode.map5
        CardFace
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "body" Json.Decode.string)
        (Json.Decode.field "powerCost" Json.Decode.string)
        (Json.Decode.field "moneyCost" Json.Decode.string)
        (Json.Decode.field "pointValue" Json.Decode.string)
