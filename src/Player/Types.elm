module Player.Types exposing (Player, PlayerId(..))

import Card.Types exposing (Card)

type alias Player = {
    hand: List Card,
    deck: Int,
    discard: Int,
    id: PlayerId,
    money: Int,
    power: Int,
    influence: Int,
    batteries: Int
}

type PlayerId =
    Alpha |
    Beta |
    Gamma |
    Delta
