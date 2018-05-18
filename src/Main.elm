module Main exposing (..)

import Card exposing (Card(..), renderCard, CardFace)
import Player.Types exposing (Player, PlayerId(..))
import Game.Types exposing (Game)
import Game.View exposing (renderGame)
import Game.Decoder exposing (gameDecoder)
import Message exposing (Msg(..))
import Html exposing (Html, div, text, program, button)
import WebSocket
import Json.Decode exposing (..)


-- MODEL

type alias Model = {
    game : Game,
    myId : PlayerId
}

init: (Model, Cmd Msg)
init =
    (
        {
            game = Game
                Alpha
                (List.map playerFactory [Alpha, Beta, Gamma, Delta])
                (List.map (\num -> Card.Front (CardFace "Card" (toString num) "1pow" "$2" "3pt")) (List.range 0 5)),
            myId = Alpha
        },
        WebSocket.send wsUrl "foo"
    )

type alias Hand = List Card

playerFactory id =
    Player (List.map (\num -> Card.Front (CardFace "Card" (toString num) "1pow" "$2" "3pt")) (List.range 0 5)) 0 0 id 0 0 0 0


-- VIEW

view: Model -> Html Msg
view model =
    renderGame model.game model.myId


-- UPDATE

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
        (model, Cmd.none)
    PassTurn ->
        (model, Cmd.none)
    WsMsg txt ->
        (
            {
                model |
                game =
                    let
                        result = Json.Decode.decodeString Game.Decoder.gameDecoder txt
                    in
                        case result of
                            Ok val ->
                                Debug.log "succ" val
                            Err e ->
                                Tuple.first (model.game, (Debug.log "problemo" e))
            },
            Cmd.none
        )
    PlayMsg player index ->
        (
            model,
            Cmd.none
        )


-- SUBSCRIPTIONS

subscriptions: Model -> Sub Msg
subscriptions model =
    WebSocket.listen wsUrl WsMsg


-- MAIN

main: Program Never Model Msg
main =
    program
        {
            init = init,
            view = view,
            update = update,
            subscriptions = subscriptions
        }

wsUrl : String
wsUrl =
    "ws://unixdeva22:30322"
