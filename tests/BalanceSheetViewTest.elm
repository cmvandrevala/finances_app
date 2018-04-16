module BalanceSheetViewTest exposing (suite)

import ElmTestBDDStyle exposing (..)
import BalanceSheetView exposing (view)
import Model exposing (..)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, text, tag)
import ElmTestBDDStyle exposing (..)
import Expect
import Date exposing (..)
import Date.Extra exposing (..)


lastUpdatedOne : Date
lastUpdatedOne =
    fromParts 2000 Jan 12 0 0 0 0


lastUpdatedTwo : Date
lastUpdatedTwo =
    fromParts 2000 Feb 12 0 0 0 0


mockModel : Model
mockModel =
    (Model
        [ (BalanceSheetRow
            lastUpdatedOne
            "institution one"
            "account one"
            "investment one"
            "owner one"
            100.23
          )
        , (BalanceSheetRow
            lastUpdatedTwo
            "institution two"
            "account two"
            "investment two"
            "owner two"
            98
          )
        ]
    )


suite : Test
suite =
    describe "the balance sheet view"
        [ it "has a title of Balance Sheet" <|
            ((view initialModel)
                |> Query.fromHtml
                |> Query.find [ tag "h1" ]
                |> Query.has [ text "Balance Sheet" ]
            )
        , it "displays the last updated header" <|
            ((view initialModel)
                |> Query.fromHtml
                |> Query.findAll [ class "last-updated-header" ]
                |> Query.count (Expect.equal 1)
            )
        , it "displays the institution header" <|
            ((view initialModel)
                |> Query.fromHtml
                |> Query.findAll [ class "institution-header" ]
                |> Query.count (Expect.equal 1)
            )
        , it "displays the account header" <|
            ((view initialModel)
                |> Query.fromHtml
                |> Query.findAll [ class "account-header" ]
                |> Query.count (Expect.equal 1)
            )
        , it "displays the investment header" <|
            ((view initialModel)
                |> Query.fromHtml
                |> Query.findAll [ class "investment-header" ]
                |> Query.count (Expect.equal 1)
            )
        , it "displays the owner header" <|
            ((view initialModel)
                |> Query.fromHtml
                |> Query.findAll [ class "owner-header" ]
                |> Query.count (Expect.equal 1)
            )
        , it "displays the value header" <|
            ((view initialModel)
                |> Query.fromHtml
                |> Query.findAll [ class "value-header" ]
                |> Query.count (Expect.equal 1)
            )
        , it "displays each of the balance sheet rows" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.count (Expect.equal 2)
            )
        , it "displays a formatted last-updated date associated with a row" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.first
                |> Query.has [ text "2000-01-12" ]
            )
        , it "displays an institution associated with a row" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.first
                |> Query.has [ text "institution one" ]
            )
        , it "displays an account associated with a row" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.first
                |> Query.has [ text "account one" ]
            )
        , it "displays an investment associated with a row" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.first
                |> Query.has [ text "investment one" ]
            )
        , it "displays an owner associated with a row" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.first
                |> Query.has [ text "owner one" ]
            )
        , it "displays the value associated with a row" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.first
                |> Query.has [ text "100.23" ]
            )
        , it "rounds the value to two decimal places" <|
            ((view mockModel)
                |> Query.fromHtml
                |> Query.findAll [ class "balance-sheet-row" ]
                |> Query.index 1
                |> Query.has [ text "98.00" ]
            )
        ]
