module Deck exposing
    ( Deck
    , fullSuit, fullFace, fullDeck, randomDeck
    , appendCard
    )

{-| Deck types, generators, and manipulating functions


# Types

@docs Deck


# Construction

@docs fullSuit, fullFace, fullDeck, randomDeck


# Manipulation

@docs appendCard

-}

import Cards exposing (Card(..), Face(..), Suit(..))
import Random
import Random.List exposing (shuffle)


{-| A representation of an arbitrary deck or hand of cards.
-}
type alias Deck =
    List Card


{-| Make a deck of all the cards in a single suit.

Makes the deck in A-K order

    fullSuit Spades == [ Card Spades Ace, Card Spades Two, Card Spades Three, Card Spades Four, Card Spades Five, Card Spades Six, Card Spades Seven, Card Spades Eight, Card Spades Nine, Card Spades Ten, Card Spades Jack, Card Spades Queen, Card Spades King ]

-}
fullSuit : Suit -> Deck
fullSuit suit =
    List.map (Card suit) [ Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King ]


{-| Make a deck of all the cards for a single face.

Makes the deck in standard order.

    fullFace Ace == [ Card Spades Ace, Card Diamonds Ace, Card Clubs Ace, Card Hearts Ace ]

-}
fullFace : Face -> Deck
fullFace face =
    List.map (\f -> Card f face) <| [ Spades, Diamonds, Clubs, Hearts ]


{-| A full 52-card deck in standard order.

    fullDeck == [ Card Spades Ace, Card Spades Two, ... ]

-}
fullDeck : Deck
fullDeck =
    let
        suits : List Suit
        suits =
            [ Spades, Diamonds, Clubs, Hearts ]
    in
    List.map fullSuit suits
        |> List.concat


{-| A 52-card deck in randomly shuffled order.

    type Msg = ShuffleDeck Deck
    Random.generate ShuffleDeck randomDeck

-}
randomDeck : Random.Generator Deck
randomDeck =
    shuffle fullDeck


{-| Add a card to the end of the deck.

    appendCard (Card Spades Ace) [ Card Spades Three, Card Spades Two ] == [ Card Spades Three, Card Spades Two, Card Spades Ace ]

-}
appendCard : Card -> Deck -> Deck
appendCard card deck =
    List.foldr (::) [ card ] deck
