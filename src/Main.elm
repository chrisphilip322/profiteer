module Main exposing (..)

import Card exposing (Card(..), renderCard, CardFace)
import Player.View exposing (renderPlayer)
import Player.Types exposing (Player, PlayerId(..))
import Message exposing (Msg(..))
import Html exposing (Html, div, text, program, button)
import WebSocket


-- MODEL

type alias Model = {
    player: Player,
    myId: PlayerId
}

init: (Model, Cmd Msg)
init =
    (
        {
            player = Player (List.map (\num -> Card.Front (CardFace "Card" (toString num) "1pow" "$2" "3pt")) (List.range 0 5)) 0 0 (Alpha) 0 0 0 0,
            myId = Alpha
        },
        WebSocket.send "ws://unixdeva22:30322/" "foo"
    )

type alias Hand = List Card


-- VIEW

view: Model -> Html Msg
view model =
    div []
        (
            (renderPlayer model.player model.myId) ::
            (renderPlayer model.player Beta) ::
            (renderPlayer model.player Gamma) ::
            (renderPlayer model.player Delta) ::
            []
        )


-- UPDATE

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
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
