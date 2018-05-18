module Main exposing (..)

import Connection exposing (..)
import Player.Types exposing (PlayerId(Alpha))
import Game.Types exposing (Game)
import Game.View exposing (renderGame)
import Game.Decoder exposing (gameDecoder)
import Message exposing (Msg(..))
import Html exposing (Html, program)
import Json.Decode exposing (decodeString)


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
                []
                [],
            myId = Alpha
        },
        Connection.connect
    )


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
        (model, Connection.passTurn model.myId)
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
                                val
                            Err e ->
                                model.game
            },
            Cmd.none
        )
    PlayMsg index ->
        (
            model,
            Connection.playCard index model.myId
        )


-- SUBSCRIPTIONS

subscriptions: Model -> Sub Msg
subscriptions model =
    Connection.subscribe


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
