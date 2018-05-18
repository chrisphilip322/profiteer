module Game.Decoder exposing (..)

import Game.Types exposing (..)
import Player.Decoder exposing (..)
import Card exposing (..)

import Json.Decode exposing (..)

gameDecoder : Decoder Game
gameDecoder =
    Json.Decode.map3
        Game
        (Json.Decode.field "activePlayer" playerIdDecoder)
        (Json.Decode.field "players" (list playerDecoder))
        (Json.Decode.field "board" (list cardDecoder))
