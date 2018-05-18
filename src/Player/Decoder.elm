module Player.Decoder exposing (playerDecoder, playerIdDecoder)

import Card exposing (Card, cardDecoder)
import Player.Types exposing (Player, PlayerId(..))
import Json.Decode exposing (..)

playerDecoder: Decoder Player
playerDecoder =
    Json.Decode.map8
        Player
        (Json.Decode.field "hand" (Json.Decode.list cardDecoder))
        (Json.Decode.field "deck" Json.Decode.int)
        (Json.Decode.field "discard" Json.Decode.int)
        (Json.Decode.field "playerId" playerIdDecoder)
        (Json.Decode.field "money" Json.Decode.int)
        (Json.Decode.field "power" Json.Decode.int)
        (Json.Decode.field "influence" Json.Decode.int)
        (Json.Decode.field "batteries" Json.Decode.int)

playerIdDecoder : Decoder PlayerId
playerIdDecoder =
    let
        convert : String -> Decoder PlayerId
        convert s =
          case s of
            "Alpha" ->
                succeed Alpha
            "Beta" ->
                succeed Beta
            "Gamma" ->
                succeed Gamma
            "Delta" ->
                succeed Delta
            _ ->
                fail "Invalid playerId"
    in
        string |> andThen convert
