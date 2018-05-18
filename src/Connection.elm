module Connection exposing (..)

import Message exposing (Msg(..))
import Player.Types exposing (PlayerId)
import Json.Encode
import WebSocket


wsUrl : String
wsUrl =
    "ws://unixdeva22:30322"

subscribe : Sub Msg
subscribe =
    WebSocket.listen wsUrl WsMsg

playCard : Int -> PlayerId -> Cmd Msg
playCard index myId =
    WebSocket.send wsUrl
        (Json.Encode.encode
            0
            (Json.Encode.object
                [
                    ("index", Json.Encode.int index),
                    ("playerId", Json.Encode.string (toString myId)),
                    ("action", Json.Encode.string "playCard")
                ]
            )
        )

passTurn : PlayerId -> Cmd Msg
passTurn myId =
    WebSocket.send wsUrl
        (Json.Encode.encode
            0
            (Json.Encode.object
                [
                    ("playerId", Json.Encode.string (toString myId)),
                    ("action", Json.Encode.string "passTurn")
                ]
            )
        )

connect : Cmd Msg
connect =
    WebSocket.send wsUrl "connect"
