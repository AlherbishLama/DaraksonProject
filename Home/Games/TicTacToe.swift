//
//  TicTacToe.swift
//  Home
//
//  Created by Lama Alherbish on 22/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import UIKit

class TicTacToe : UIViewController {
    
    
    @IBOutlet weak var WinningLabel: UILabel!
    @IBOutlet weak var PlayAgainButton: UIButton!
    var gameIsActive = true
    var activePlayer = 1 //Cross
    var whoWon = ""
    var game = [0,0,0,0,0,0,0,0,0]
    let winingCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func action(_ sender: AnyObject) {
        
        if (game[sender.tag - 1 ] == 0 && gameIsActive == true){
            game[sender.tag - 1 ] = activePlayer
            
            if (activePlayer == 1){
                sender.setImage(UIImage(named: "iconCross5.png"), for: UIControl.State())
              activePlayer = 2
            }else{
                sender.setImage(UIImage(named: "iconO3.png"), for: UIControl.State())
                activePlayer = 1
            }
            
        }
        for combination in winingCombinations{
            if game[combination[0]] != 0 && game[combination[0]] == game[combination[1]] && game[combination[1]] == game[combination[2]]{
                gameIsActive = false
                
                if game[combination[0]] == 1 {
                    //cross has won
                    whoWon = "Cross"
                    WinningLabel.text = "Cross WIN !!!"
                    print("Cross")
                }else{
                    //nought has won
                    whoWon = "Nought"
                    print("Nought")
                    WinningLabel.text = "Nought WIN !!!"
                }
                WinningLabel.isHidden = false
                PlayAgainButton.isHidden = false
            }
        }
        
    }
    
    
    @IBAction func PlayAgainAction(_ sender: Any) {
        
         game = [0,0,0,0,0,0,0,0,0]
         gameIsActive = true
        if whoWon == "Nought"{
           activePlayer = 1 //Cross
        }else{
           activePlayer = 2 //Nought
        }
        WinningLabel.isHidden = true
        PlayAgainButton.isHidden = true
        
        for i in 1...9 {
                  let button = view.viewWithTag(i) as! UIButton
                  button.setImage(nil, for: UIControl.State())
              }
    
    }
    

}
