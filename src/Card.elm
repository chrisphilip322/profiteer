module Card exposing (Card, renderCard)

import Html exposing (Html, div, text, Attribute, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

type alias Card = {
    name: String,
    body: String,
    powerCost: String,
    moneyCost: String,
    pointValue: String
}

renderCard: Card -> Maybe msg -> Html msg
renderCard card maybe_play =
    div [ cardStyle ]
        [
            div []
                [
                    div [ leftSideStyle ] [ text card.name ],
                    div [ rightSideStyle ] [ text card.powerCost ]
                ],
            div [ bodyStyle ]
                (List.append
                    [ text card.body ]
                    (
                      case maybe_play of
                        Just play ->
                            [ button [ onClick play ] [ text "Play" ] ]
                        Nothing ->
                            []
                    )
                ),
            div [ bottomRowStyle ]
                [
                    div [ leftSideStyle ] [ text card.moneyCost ],
                    div [ rightSideStyle ] [ text card.pointValue ]
                ]
        ]

cardStyle: Attribute msg
cardStyle =
    style [
        ("width", "200px"),
        ("height", "300px"),
        ("display", "inline-block"),
        ("border", "1px solid black"),
        ("position", "relative")
    ]

leftSideStyle: Attribute msg
leftSideStyle =
    style [
        ("display", "inline-block")
    ]

rightSideStyle: Attribute msg
rightSideStyle =
    style [
        ("display", "inline-block"),
        ("float", "right")
    ]

bottomRowStyle: Attribute msg
bottomRowStyle =
    style [
        ("position", "absolute"),
        ("bottom", "0"),
        ("width", "100%")
    ]

bodyStyle: Attribute msg
bodyStyle =
    style [
        ("position", "absolute"),
        ("bottom", "40%"),
        ("width", "100%")
    ]
