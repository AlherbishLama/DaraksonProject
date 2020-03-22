//
//  HomeController.swift
//  Home
//
//  Created by Lama Alherbish on 1/29/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import UIKit
import UserNotifications
import SafariServices

class HomeController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var Logo3: UIImageView!
    @IBOutlet weak var Logo2: UIImageView!
    @IBOutlet weak var Logo1: UIImageView!
    @IBOutlet weak var Logo4: UIImageView!
    @IBOutlet weak var bhckgroundstartpage: UIImageView!
    @IBOutlet weak var Logo5: UIImageView!
    let ArrayOfMenuImage = ["Play","2","About"]
    
    let ArrayOfColors = ["T","B","P"]
    
    let ArrayOfMenuText = ["Play","Login","Help"]
    
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
             let storyboard = self.storyboard?.instantiateViewController(identifier: "DeveloperGame") as! DeveloperGames
                                                                                       
                      self.navigationController?.pushViewController(storyboard, animated: true)
        } else if item == "Help" {
                       //    let storyboard = self.storyboard?.instantiateViewController(identifier: "DeveloperGame") as! DeveloperGames
                                 openURL(url: "https://ilv0hoq7zrpnr8zqkghitw-on.drv.tw/Sprint3/www.landingpage/index3.html")
                                 //   self.navigationController?.pushViewController(storyboard, animated: true)
                      }
        
        
    }
    
    func rotate1(imageView: UIImageView, aCircleTime: Double) { //CABasicAnimation
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Double.pi * 4 //Minus can be Direction
            rotationAnimation.duration = aCircleTime
        rotationAnimation.repeatCount = 1.0
            imageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
           cell.layer.transform = rotationTransform
           
        UIView.animate(withDuration: 1.0,delay: 1.7, options: .curveLinear ,animations: {
               cell.layer.transform = CATransform3DIdentity
           })
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
        }//startpage

             UIView.animate(withDuration: 1, animations: {
                 self.Logo5.frame.origin.y += 140
             }, completion: nil)
             
             UIView.animate(withDuration: 1, animations: {
                 self.Logo3.frame.origin.y -= 150
             }, completion: nil)
             
             UIView.animate(withDuration: 1, animations: {
                 self.Logo2.frame.origin.y -= 150
             }, completion: nil)
             
             UIView.animate(withDuration: 1, animations: {
                 self.Logo4.frame.origin.x -= 3
             }, completion: nil)
             
             UIView.animate(withDuration: 1, animations: {
                 self.Logo1.frame.origin.x += 7
             }, completion: nil)
             
             
            rotate1(imageView: Logo1, aCircleTime: 1)
            rotate1(imageView: Logo4, aCircleTime: 1)
             
            

             
             let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 500, 10, 0)
             bhckgroundstartpage.layer.transform = rotationTransform
             UIView.animate(withDuration: 1, animations: {
                 self.bhckgroundstartpage.layer.transform = CATransform3DIdentity
                 self.bhckgroundstartpage.frame.origin.x += 1
                 
             }, completion: nil)
            self.bhckgroundstartpage.layer.transform = CATransform3DIdentity


             UIView.animate(withDuration: 1,delay: 0.001, options: .curveLinear , animations: {
                     
                 UIView.animate(withDuration:2, animations: {() -> Void in
                       self.Logo5.frame.origin.y += 40
                    }, completion: {(_ finished: Bool) -> Void in
                     UIView.animate(withDuration: 1,  animations:{() -> Void in
                      self.Logo5.frame.origin.y -= 40            })
             })
              })
             
             UIView.animate(withDuration: 1,delay: 0.01, options: .curveLinear , animations: {
                     
                 UIView.animate(withDuration:2, animations: {() -> Void in
                       self.Logo1.frame.origin.y -= 20
                    }, completion: {(_ finished: Bool) -> Void in
                     UIView.animate(withDuration: 1,  animations:{() -> Void in
                      self.Logo1.frame.origin.y += 20            })
             })
              })
             UIView.animate(withDuration: 1,delay: 0.001, options: .curveLinear , animations: {
                           
                       UIView.animate(withDuration:2, animations: {() -> Void in
                             self.Logo4.frame.origin.y += 30
                          }, completion: {(_ finished: Bool) -> Void in
                           UIView.animate(withDuration: 1,  animations:{() -> Void in
                            self.Logo4.frame.origin.y -= 30            })
                   })
                    })
             UIView.animate(withDuration: 1,delay: 0.01, options: .curveLinear , animations: {
                                  
                              UIView.animate(withDuration:2, animations: {() -> Void in
                                    self.Logo3.frame.origin.y -= 30
                                 }, completion: {(_ finished: Bool) -> Void in
                                  UIView.animate(withDuration: 1,  animations:{() -> Void in
                                   self.Logo3.frame.origin.y += 30            })
                          })
                           })
             UIView.animate(withDuration: 1,delay: 0.001, options: .curveLinear , animations: {
                                         
                                     UIView.animate(withDuration:2, animations: {() -> Void in
                                           self.Logo2.frame.origin.y -= 30
                                        }, completion: {(_ finished: Bool) -> Void in
                                         UIView.animate(withDuration: 1,  animations:{() -> Void in
                                          self.Logo2.frame.origin.y += 30            })
                                 })
                                  })
           
             

        
             UIView.animate(withDuration: 1.1,delay: 1.2, options: .curveLinear, animations: {
                 
                 UIView.animate(withDuration:1.1, animations: {() -> Void in
                   self.bhckgroundstartpage.layer.transform = CATransform3DIdentity
                   self.bhckgroundstartpage.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: {(_ finished: Bool) -> Void in
                 UIView.animate(withDuration: 1.1, delay: 1.6, options: .curveLinear, animations:{() -> Void in
                   self.bhckgroundstartpage.transform = CGAffineTransform(scaleX: 10, y: 10)
                     self.Logo2.alpha = 0.0
                     self.Logo1.alpha = 0.0
                     self.Logo3.alpha = 0.0
                     self.Logo4.alpha = 0.0
                     self.Logo5.alpha = 0.0
                    self.bhckgroundstartpage.alpha = 0.0

               
                 })  })  })
    
    
    }


      // URL
         func openURL (url: String){
             guard let url = URL(string: url) else {return}
          let safariViewController=SFSafariViewController (url: url)
          present(safariViewController, animated: true)
          //UIApplication.shared.open(url, options: [:])
         }
    
}
