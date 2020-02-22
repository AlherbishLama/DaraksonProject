//
//  HomeController.swift
//  Home
//
//  Created by Lama Alherbish on 1/29/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import UIKit
import UserNotifications

class HomeController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    let ArrayOfMenuImage = ["Play","Learn","2","About"]
    
    let ArrayOfColors = ["T","Y","B","P"]
    
    let ArrayOfMenuText = ["Play","Learn","Login","Help"]
    
    struct globalNotification{
        static var DidAllow1 = Bool()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayOfMenuImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        cell.TEXT.text = ArrayOfMenuText[indexPath.row]
        cell.rect.image = UIImage(named: ArrayOfColors[indexPath.row]+".png")
        cell.robot.image = UIImage(named: ArrayOfMenuImage[indexPath.row]+".png")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let item = ArrayOfMenuText[indexPath.row]
        
        if item == "Login" {
            let storyboard = self.storyboard?.instantiateViewController(identifier: statics.LoginView) as! LoginController
                                                                 
                            self.navigationController?.pushViewController(storyboard, animated: true)
            
        } else if item == "Play" {
            let storyboard = self.storyboard?.instantiateViewController(identifier: "Play") as! playview
                                                                            
           self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .sound , .badge]) { (didAllow, error) in
            if didAllow {
                globalNotification.DidAllow1 = true
                if HomeController.globalNotification.DidAllow1 == true {
                    let content = UNMutableNotificationContent()
                    content.title = "your car is waiting for you"
                    content.badge = 1
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    let request = UNNotificationRequest(identifier: "waiting", content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
            } else {
                globalNotification.DidAllow1 = false
            }
        }
    }

    
}
