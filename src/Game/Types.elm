module Game.Types exposing (..)

import Card exposing (Card)
import Player.Types exposing (Player, PlayerId)

type alias Game = {
    activePlayer : PlayerId,
    players : List Player,
    board : List Card
}
