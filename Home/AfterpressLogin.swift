//
//  AfterpressLogin.swift
//  Home
//
//  Created by Lama Alherbish on 08/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class AfterpressLogin: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    let ArrayOfMenuImage = ["Play","Learn","About"]
       
    let ArrayOfColors = ["T","Y","P"]
       
    let ArrayOfMenuText = ["Play","Learn","Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func profileTappedd(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: "profilett") as! profileController
                                                       
       self.navigationController?.pushViewController(storyboard, animated: false)
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayOfMenuImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! HomeTableViewCell2
        
        cell.TEXT.text = ArrayOfMenuText[indexPath.row]
        cell.rect.image = UIImage(named: ArrayOfColors[indexPath.row]+".png")
        cell.robot.image = UIImage(named: ArrayOfMenuImage[indexPath.row]+".png")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: false)
           
           guard let cell = tableView.cellForRow(at: indexPath) else { return }
           
           let item = ArrayOfMenuText[indexPath.row]
           
           if item == "Play" {
              let storyboard = self.storyboard?.instantiateViewController(identifier: "Play") as! playview
                                                                    
                self.navigationController?.pushViewController(storyboard, animated: true)
               
           } else if item == "Learn" {
           } else {
            
            
        }
           
       }
    
    
}
