//
//  CardMatchViewController.swift
//  Home
//
//  Created by Lama Alherbish on 23/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit

class CardMatchViewController : UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var TimerLabel: UILabel!
    

    var timer:Timer?
    var milliseconds:Float = 20 * 1000 //10 seconds
    var model = CardModel()
    var cardArray = [Card]()
    var firstFlippedCardIndex: IndexPath?
    var secondFlippedCardIndex: IndexPath?
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let itemSize = UIScreen.main.bounds.width/3-3
       let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20,left: 0,bottom: 10,right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        myCollectionView.collectionViewLayout = layout
        
       cardArray = model.getCards()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapesd), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode:.common)
    }
    
    @objc func timerElapesd(){
       milliseconds -= 1
        let seconds = String(format: "%.2f", milliseconds/1000)
        TimerLabel.text = "Time Remaining: \(seconds)"
        
        if milliseconds <= 0 {
            timer?.invalidate()
            TimerLabel.textColor = UIColor.white
            TimerLabel.textAlignment = .center
            checkGameEnded()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReCell", for: indexPath) as! MatchViewCell
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MatchViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            cell.flip()
            card.isFlipped = true
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }else{
                checkForMatches(indexPath)
            }
            
        }
                
    }

    func checkForMatches(_ secondFlippedCardIndex: IndexPath){
        let cardOneCell = myCollectionView.cellForItem(at: firstFlippedCardIndex!) as? MatchViewCell
        
        let cardTwoCell = myCollectionView.cellForItem(at: secondFlippedCardIndex) as? MatchViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()

            
        }else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded(){
        var isWon = true
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        var title = ""
        var message = ""
        
        if isWon == true {
            if milliseconds > 0 {
                [timer?.invalidate()];
                timer = nil ;
                title = "Congratulations"
                message = "You've WON !!"
                statics.alert(message: message, title: title, view: self)
            }
            
        }else {
            if milliseconds <= 0 {
                [timer?.invalidate()];
                timer = nil ;
                title = "Game over"
                message = "You've lost :("
                statics.alert(message: message, title: title, view: self)
            }
        }
    }
    
    
}//end of CardMatchViewController

