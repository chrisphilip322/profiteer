module Game.View exposing (..)

import Message exposing (Msg(PassTurn))
import Card exposing (Card, renderCard)
import Game.Types exposing (..)
import Player.Types exposing (PlayerId)
import Player.View exposing (..)

import Html exposing (Html, div, text, program, button, Attribute)
import Html.Events exposing (onClick)
import List exposing (foldl)
import Html.Attributes exposing (style)

renderGame : Game -> PlayerId -> Html Msg
renderGame game myId =
    div []
        ((renderBoard game.board) :: (List.foldl
            (\player -> (::) (Player.View.renderPlayer player myId))
            []
            game.players
        ))

renderBoard : List Card -> Html Msg
renderBoard board =
    div [boardStyle]
        (
            (button [onClick PassTurn] [text "Pass Turn"]) ::
            (List.map ((flip renderCard) Nothing) board)
        )

boardStyle : Attribute msg
boardStyle =
    style [
        ("position", "absolute"),
        ("top", "300px"),
        ("left", "300px")
    ]
