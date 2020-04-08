//  CardModel.swift
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Completed-----------------------------------------------

import Foundation

class CardModel {
    
    func getCards() -> [Card]{
        var generatdCardsArray = [Card]()
   
        for _ in 1...6 {
            let randomNmber = arc4random_uniform(6) + 1
            print(randomNmber)
            let cardOne = Card()
            cardOne.imageName = "card\(randomNmber)"
            generatdCardsArray.append( cardOne)
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNmber)"
            generatdCardsArray.append(cardTwo)
        }
        return generatdCardsArray
    }
}
