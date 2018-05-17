module Player.View exposing (..)

import Player.Types exposing (Player, PlayerId(..))
import Card exposing (renderCard)
import Message exposing (Msg(PlayMsg))
import Html exposing (Html, div, text, Attribute, button)
import Html.Attributes exposing (style)

renderPlayer: Player -> PlayerId -> Html Msg
renderPlayer player myId =
    div
        [
            playerStyle (getPositionStyle player.id myId)
        ]
        (List.append
            (
                (div [] [text "foo"]) ::
                (renderDeck player) ::
                (renderHand player myId)
            )
            [ renderDiscard player ]
        )

renderHand: Player -> PlayerId -> List (Html Msg)
renderHand player myId =
    List.indexedMap
        (\index card ->
            renderCard card
                (
                    if player.id == myId then
                        Just (PlayMsg player index)
                    else
                        Nothing
                )
        )
        player.hand

renderDeck: Player -> Html Msg
renderDeck player =
    div
        [
            style
                [
                    ("transform", "rotate(-90deg)"),
                    ("transform-origin", "100% 100%"),
                    ("display", "inline-block")
                ]
        ]
        [
            text ("deck(" ++ toString player.deck ++ ")")
        ]

renderDiscard: Player -> Html Msg
renderDiscard player =
    div
        [
            style
                [
                    ("transform", "rotate(90deg)"),
                    ("transform-origin", "0 100%"),
                    ("display", "inline-block")
                ]
        ]
        [
            text ("discard(" ++ toString player.discard ++ ")")
        ]

playerStyle: List (String, String) -> Attribute msg
playerStyle moreStyle =
    style
        (List.append
            moreStyle
            [
                ("display", "inline-block"),
                ("text-align", "center"),
                ("position", "absolute")
            ]
        )

getPositionStyle: PlayerId -> PlayerId -> List (String, String)
getPositionStyle playerId myId =
    let
        playerNum = playerIdToInt playerId
        myNum = playerIdToInt myId
    in
      case (playerNum - myNum) % 4 of
        0 ->
            myStyle
        1 ->
            leftStyle
        2 ->
            topStyle
        3 ->
            rightStyle
        _ -> myStyle

playerIdToInt: PlayerId -> Int
playerIdToInt playerId =
  case playerId of
    Alpha ->
        0
    Beta ->
        1
    Gamma ->
        2
    Delta ->
        3


myStyle: List (String, String)
myStyle =
    [
        ("bottom", "0"),
        ("width", "100%")
    ]

leftStyle: List (String, String)
leftStyle =
    [
        ("transform", "scale(0.8) rotate(90deg) translateX(0%) translateY(-100%)"),
        ("transform-origin", "0 0")
    ]

rightStyle: List (String, String)
rightStyle =
    [
        ("transform", "scale(0.8) rotate(-90deg) translateX(30%)"),
        ("transform-origin", "100% 100%"),
        ("right", "0")
    ]

topStyle: List (String, String)
topStyle =
    [
        ("transform", "scale(0.8)"),
        ("top", "0"),
        ("text-align", "center"),
        ("width", "100%")
    ]
