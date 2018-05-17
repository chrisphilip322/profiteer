module Main exposing (..)

import Card exposing (Card, renderCard)
import Html exposing (Html, div, text, program, button)
import Html.Events exposing (onClick)
import WebSocket


-- MODEL

type alias Model = {
    text: String,
    card: Card,
    deck: List Card,
    hand: Hand,
    messages: List String
}

init: (Model, Cmd Msg)
init =
    (
        {
            text = "foo",
            card = Card "JTMS" "Win the game" "1pow" "$2" "3pt",
            deck = List.map (\num -> Card "Card" (toString num) "1pow" "$2" "3pt") (List.range 0 52),
            hand = [],
            messages = []
        },
        WebSocket.send "ws://unixdeva22:30322/" "foo"
    )

type alias Hand = List Card


-- MESSAGES

type Msg =
    NoOp |
    Draw |
    PlayFromHand Int |
    WsMsg String


-- VIEW

view: Model -> Html Msg
view model =
    div []
        (List.append
            (List.append
                [
                    text model.text,
                    (renderCard model.card Nothing),
                    button [onClick Draw] [text "Draw!"]
                ]
                (List.map (\msgText -> div [] [text msgText]) model.messages)
            )
            (List.indexedMap
                (\index card -> renderCard card (Just (PlayFromHand index)))
                model.hand
            )
        )


-- UPDATE

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
        (model, Cmd.none)
    Draw ->
        (
          case model.deck of
            head :: rest ->
                {
                    model |
                    hand = head :: model.hand,
                    deck = rest
                }
            [] ->
                model,

            WebSocket.send "ws://unixdeva22:30322" "draw"
        )
    PlayFromHand index ->
        (
            {
                model |
                text = toString index
            },
            Cmd.none
        )
    WsMsg txt ->
        (
            {
                model |
                messages = txt :: model.messages
            },
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
