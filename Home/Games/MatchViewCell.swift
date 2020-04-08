//  MatchViewCell.swift
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status :Not Completed-----------------------------------------------

import UIKit

class MatchViewCell : UICollectionViewCell  {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var BackImageView: UIImageView!
    var card:Card?
    
    func setCard(_ card:Card){
        self.card = card
        
                if card.isMatched == true {
                    BackImageView.alpha = 0
                    imageView.alpha = 0
                    return
                }else {
                    BackImageView.alpha = 1
                    imageView.alpha = 1
                        }
        
        imageView.image = UIImage(named: card.imageName)
        BackImageView.image = UIImage(named:"logo.png")
        
        if card.isFlipped == true {
            UIView.transition(from: BackImageView, to: imageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }else{
            UIView.transition(from: imageView, to: BackImageView, duration: 0, options: [.showHideTransitionViews , .transitionFlipFromLeft], completion: nil)
        }
        
        
    }
    
    func flip(){
        UIView.transition(from: BackImageView, to: imageView, duration: 0.3, options: [.transitionFlipFromLeft , .showHideTransitionViews], completion: nil)
    }
    
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.imageView, to: self.BackImageView, duration: 0.3, options: [.transitionFlipFromRight , .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func remove() {
        BackImageView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.imageView.alpha = 0
        }, completion: nil)
    }
    
    
}
