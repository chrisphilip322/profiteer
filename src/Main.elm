module Main exposing (..)

import Card exposing (Card, renderCard)
import Html exposing (Html, div, text, program, button)
import Html.Events exposing (onClick)


-- MODEL

type alias Model =
  { text: String
  , card: Card
  , deck: List Card
  , hand: Hand
  }

init: (Model, Cmd Msg)
init =
  ( { text = "foo"
    , card = Card "JTMS" "Win the game"
    , deck = List.map (\num -> Card "Card" (toString num)) (List.range 0 52)
    , hand = []
    }
  , Cmd.none
  )

type alias Hand = List Card


-- MESSAGES

type Msg
  = NoOp
  | Draw
  | PlayFromHand Int


-- VIEW

view: Model -> Html Msg
view model =
  List.indexedMap (\index card -> renderCard card (Just (PlayFromHand index))) model.hand
   |> List.append
        [ text model.text
        , (renderCard model.card Nothing)
        , button [onClick Draw] [text "Draw!"]
        ]
   |> div []


-- UPDATE

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
    Draw ->
      ( case model.deck of
          head :: rest ->
            { model
              | hand = head :: model.hand
              , deck = rest
            }
          [] ->
            model
      , Cmd.none
      )
    PlayFromHand index ->
      ( { model
        | text = toString index
        }
      , Cmd.none
      )


-- SUBSCRIPTIONS

subscriptions: Model -> Sub Msg
subscriptions model =
  Sub.none


-- MAIN

main: Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
