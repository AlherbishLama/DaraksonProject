//
//  Learnpage.swift
//  Home
//
//  Created by  Hanen Alkhalf on 11/07/1441 AH.
//  Copyright © 1441 Lama Alherbish. All rights reserved.
//

import UIKit

class Learnpage: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{
    
    let LevelimagArr = ["L0","L1","L2","L3"]
    let LockimagArr = ["","Lock","Lock","Lock"]

    @IBOutlet weak var levelcollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        levelcollection.delegate = self
        levelcollection.dataSource = self 
        let width =  (view.frame.size.width - 20 ) / 2
        let layout = levelcollection.collectionViewLayout as! UICollectionViewFlowLayout
       layout.itemSize = CGSize(width: width, height: width)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
          return LevelimagArr.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? LearnCollectionViewCell
            
        cell?.Levelimag.image = UIImage(named: LevelimagArr[indexPath.row])
       cell?.Lockimag.image = UIImage(named: LockimagArr[indexPath.row])
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let  cell2 = collectionView.cellForItem(at: indexPath)
         let item = LevelimagArr[indexPath.row]
         
         if item == "L0" {
             let storyboard = self.storyboard?.instantiateViewController(identifier: "0") as! Level0
                                                                  
                             self.navigationController?.pushViewController(storyboard, animated: true)
             
         } //else if item == "Level1" {
           // let storyboard = self.storyboard?.instantiateViewController(identifier: "") as!
                                                                             
        // self.navigationController?.pushViewController(storyboard, animated: true)
     //  }
      //  else if item == "Level2" {
        // let storyboard = self.storyboard?.instantiateViewController(identifier: "") as!
                                                                             
          // self.navigationController?.pushViewController(storyboard, animated: true)
       // }
       // else if item == "Level3" {
         // let storyboard = self.storyboard?.instantiateViewController(identifier: "") as!
                                                                             
          // self.navigationController?.pushViewController(storyboard, animated: true)
         //}
//
         
     }
    
    

}
