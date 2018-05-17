module Card exposing (Card(..), renderCard, CardFace)

import Html exposing (Html, div, br, text, Attribute, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

type Card =
    Back |
    Front CardFace

type alias CardFace = {
    name: String,
    body: String,
    powerCost: String,
    moneyCost: String,
    pointValue: String
}

renderCard: Card -> Maybe msg -> Html msg
renderCard card maybe_play =
    div [ cardStyle ]
      (case card of
        Front face ->
            [
                div []
                    [
                        div [ leftSideStyle ] [ text face.name ],
                        div [ rightSideStyle ] [ text face.powerCost ]
                    ],
                div [ bodyStyle ]
                    (List.append
                        [ text face.body ]
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
                        div [ leftSideStyle ] [ text face.moneyCost ],
                        div [ rightSideStyle ] [ text face.pointValue ]
                    ]
            ]
        Back ->
            [ br [] [] ] -- empty div renders differently than div with something
                         -- so this <br/> just makes the div render normally
      )

cardStyle: Attribute msg
cardStyle =
    style [
        ("width", "200px"),
        ("height", "300px"),
        ("display", "inline-block"),
        ("border", "1px solid black"),
        ("position", "relative"),
        ("text-align", "left")
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
