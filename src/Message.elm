module Message exposing (Msg(..))

type Msg =
    NoOp |
    WsMsg String |
    PlayMsg Int |
    PassTurn
