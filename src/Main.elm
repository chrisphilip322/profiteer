module Main exposing (..)

import Card exposing (Card(..), renderCard, CardFace)
import Player.Types exposing (Player, PlayerId(..))
import Game.Types exposing (Game)
import Game.View exposing (renderGame)
import Message exposing (Msg(..))
import Html exposing (Html, div, text, program, button)
import WebSocket


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
        WebSocket.send "ws://unixdeva22:30322/" "foo"
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
            model,
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
    WebSocket.listen "ws://unixdeva22:30322" WsMsg


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
