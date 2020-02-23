//
//  CardModel.swift
//  Home
//
//  Created by Lama Alherbish on 23/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

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
