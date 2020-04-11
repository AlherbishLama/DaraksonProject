//  Learnpage.swift
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Not Completed-----------------------------------------------
import UIKit // for UI object
import Firebase // for linking the project with firebase.
// Variables 
var levell0 = false
var levell1 = false
var levell2 = false
var LockimagArr = ["","Lock","Lock","Lock"]
var childLevel = ""
//-----------------------------start of the class Learnpage ---------------------------------------------------------
class Learnpage: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{
    
    let LevelimagArr = ["L0","L1","L2","L3"]
    
    @IBAction func unwind(_ sender: UIStoryboardSegue){}
    @IBOutlet weak var levelcollection: UICollectionView!
    override func viewDidLoad() {
        childLevel = statics.childLevel
        super.viewDidLoad()
        if (levell0 == true || childLevel == "1"){
           LockimagArr[1] = ""
        }
         if (levell1 == true || childLevel == "2"){
            LockimagArr[1] = ""
           LockimagArr[2] = ""
        }
        
        
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
            //if (levell0){
           //     LockimagArr[1] = ""
            //}
             
         } else if item == "L1" {
            if (levell0 == true || childLevel == "1" || childLevel == "2"){
            let storyboard = self.storyboard?.instantiateViewController(identifier: "1") as! level1
                                                                             
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
       }
        else if item == "L2" {
           if (levell1 == true || childLevel == "2"){
        let storyboard = self.storyboard?.instantiateViewController(identifier: "2") as! Level2
                                                                             
       self.navigationController?.pushViewController(storyboard, animated: true)//
           }}
        
       // else if item == "Level3" {
         // let storyboard = self.storyboard?.instantiateViewController(identifier: "") as!
                                                                             
          // self.navigationController?.pushViewController(storyboard, animated: true)
         //}
//
     }


}
