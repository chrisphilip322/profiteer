module Card exposing (Card, renderCard)

import Html exposing (Html, div, text, Attribute, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

type alias Card =
  { name: String
  , body: String
  }

renderCard: Card -> Maybe msg -> Html msg
renderCard card maybe_play =
  div [ cardStyle ]
    [ div [] [ text card.name ]
    , div []
      ( List.append
        [ text card.body ]
        ( case maybe_play of
            Just play ->
              [ button [ onClick play ] [ text "Play" ] ]
            Nothing ->
              []
        )
      )
    ]

cardStyle: Attribute msg
cardStyle =
  style
    [ ("width", "200px")
    , ("height", "300px")
    , ("display", "inline-block")
    , ("border", "1px solid black")
    ]
