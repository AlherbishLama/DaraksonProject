//
//  AfterpressLogin.swift
//  Home
//
//  Created by Lama Alherbish on 08/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import SafariServices

class AfterpressLogin: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    let ArrayOfMenuImage = ["Play","Learn","About"]
       
    let ArrayOfColors = ["T","Y","P"]
       
    let ArrayOfMenuText = ["Play","Learn","Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if HomeController.globalNotification.DidAllow1 == true {
            let content = UNMutableNotificationContent()
            content.title = "your car is waiting for you"
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "waiting", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }

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
              let storyboard = self.storyboard?.instantiateViewController(identifier: "DeveloperGame") as! DeveloperGames
                                                                    
                self.navigationController?.pushViewController(storyboard, animated: true)
               
           } else if item == "Learn" {
                let storyboard = self.storyboard?.instantiateViewController(identifier: "Learnpage") as! Learnpage
                                                                                          
                         self.navigationController?.pushViewController(storyboard, animated: true)
        } else if item == "Help" {
                              //    let storyboard = self.storyboard?.instantiateViewController(identifier: "DeveloperGame") as! DeveloperGames
                                        openURL(url: "https://landpagedarakson.firebaseapp.com/")
                                        //   self.navigationController?.pushViewController(storyboard, animated: true)
                             }

    
       }
    

       // URL
          func openURL (url: String){
              guard let url = URL(string: url) else {return}
           let safariViewController=SFSafariViewController (url: url)
           present(safariViewController, animated: true)
           //UIApplication.shared.open(url, options: [:])
          }
    
    //check?
}
