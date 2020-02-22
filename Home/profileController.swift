//
//  profileController.swift
//  Home
//
//  Created by Lama Alherbish on 08/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import UserNotifications

class profileController: UIViewController {
    
   // @IBOutlet weak var BioLabel: UILabel!
    @IBOutlet weak var ChildNameTextField: UITextField!
    @IBOutlet weak var ChildHobbyTextField: UITextField!
    @IBOutlet weak var ChildAgeTextField: UITextField!
    @IBOutlet weak var CarNameTextField: UITextField!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if HomeController.globalNotification.DidAllow1 == true {
            let content = UNMutableNotificationContent()
            content.title = "your car is waiting for you"
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false)
            let request = UNNotificationRequest(identifier: "waiting", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("User is signed in.")
                guard let uid = Auth.auth().currentUser?.uid else { return}
                print("dsfghjklkjhghjk")
                Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
                    print("kjjj")
                     let db = Firestore.firestore() // refrence to the firebase obj
                    db.collection("users").whereField("uid", isEqualTo: uid)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else { //"\(myInt)"
                                for document in querySnapshot!.documents {
                                   let all = document.data()
                                    self.ChildNameTextField.text = all["ChildName"] as? String
                                    self.ChildAgeTextField.text =  "\(all["ChildAge"] ?? "" )"
                                    self.CarNameTextField.text = all["CarName"] as? String
                                    self.ChildHobbyTextField.text = all["FavoriteHobby"] as? String
                                }
                            }
                    }

                    
                    //let s = db.collection("users").document(uid)
                  //  guard let dict = snapshot.value as? [String : Any] else { return}
                    print("ffff")
                   // let usert = currentUser(uid: uid, dictionary: dict)
                //    self.ChildNameLabel.text = s.ChildName
                  //print(s.ChildName)
                    //self.ChildAgeLabel.text = u.ChildAge
                    //self.CarNameLabel.text = u.CarName
                    
                }) { (err) in
                    print(err)
                  print("lldlldlsldlslald")

                }} else {
                print("User is signed out.")
            }
    }
        // when open profile,make all text feild edit-disabled
                self.ChildNameTextField.isUserInteractionEnabled=false
                  self.ChildHobbyTextField.isUserInteractionEnabled=false
                  self.ChildAgeTextField.isUserInteractionEnabled=false
                  self.CarNameTextField.isUserInteractionEnabled=false
                  
                  //self.bioTextField.isUserInteractionEnabled=false
           
           
        
     //Reminder : add bio to database
        
    }
    
   //Edit buttun : all text feild edit-enabled
    @IBAction func editProfileTapped(_ sender: Any) {
    // edit-enabled
   self.ChildNameTextField.isUserInteractionEnabled=true
   self.ChildHobbyTextField.isUserInteractionEnabled=true
   self.ChildAgeTextField.isUserInteractionEnabled=true
   self.CarNameTextField.isUserInteractionEnabled=true
        
    //edit bio
   
    // when finish will press Done button
        
        
        
      
        
    }
    
    
    
    
    //Done hidden
    @IBAction func doneEditprofile(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func logOutTapped(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let storyboard = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeController
                                                           
            self.navigationController?.pushViewController(storyboard, animated: false)
            storyboard.navigationItem.hidesBackButton = true
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
