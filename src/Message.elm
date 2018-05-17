module Message exposing (..)

import Player.Types exposing (Player)

-- MESSAGES

type Msg =
    NoOp |
    WsMsg String |
    PlayMsg Player Int
