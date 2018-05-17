module Player.Types exposing (Player, PlayerId(..))

import Card exposing (Card)

type alias Player = {
    hand: List Card,
    deck: Int,
    discard: Int,
    id: PlayerId
}

type PlayerId =
    Alpha |
    Beta |
    Gamma |
    Delta
