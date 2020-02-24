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
    //bio
    @IBOutlet weak var bioText: UITextView!
    //buttons to hide
    @IBOutlet weak var editButtonToHide: UIButton!
    @IBOutlet weak var doneButtonToHide: UIButton!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
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
        
        
        /*
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
 */
        // will push data to feilds
        updateFeilds()
        // make all text feild disabled
        disableFeilds()
     //Reminder : add bio to database
        }
    
    
    
    
    
   //_____Edit buttun :
    @IBAction func editProfileTapped(_ sender: Any) {
                //______make them validatable
     ChildNameTextField.addTarget(self, action: #selector (validateName(textfield:)), for:.editingChanged)
        
        ChildHobbyTextField.addTarget(self, action: #selector (validateHobby(textfield:)), for:.editingChanged)
        
        ChildAgeTextField.addTarget(self, action: #selector (validateAge(textfield:)), for:.editingChanged)
        
        CarNameTextField.addTarget(self, action: #selector (validateCarName(textfield:)), for:.editingChanged)
        
        
    // edit-enabled
   self.ChildNameTextField.isUserInteractionEnabled=true
   self.ChildHobbyTextField.isUserInteractionEnabled=true
   self.ChildAgeTextField.isUserInteractionEnabled=true
   self.CarNameTextField.isUserInteractionEnabled=true
    self.bioText.isUserInteractionEnabled=true
    //edit bio will be added here
         //add img name
        
        //var name = validateName(textfield:)
        // var Hobby = validateHobby(textfield:)
       // var Age = validateAge(textfield:)
       // var carName = validateCarName(textfield:)
    
        //1 hide Edit button : Always hidden
        self.editButtonToHide.isHidden=true
            //no error will show button Done and enable it
        if errorLabel.text?.count==0{
         
          self.doneButtonToHide.isHidden=false//no error
         self.doneButtonToHide.isUserInteractionEnabled=true
            
        }else { //error will show Done but not abled
            self.doneButtonToHide.isHidden=false//no error
            self.doneButtonToHide.isUserInteractionEnabled=false
        }
        
        
        
        
      
    // when finish will press Done button
        }
    
    
    func disableFeilds(){
        
self.ChildNameTextField.isUserInteractionEnabled=false
                    self.ChildHobbyTextField.isUserInteractionEnabled=false
                    self.ChildAgeTextField.isUserInteractionEnabled=false
                    self.CarNameTextField.isUserInteractionEnabled=false
                    //bio is added
                     self.bioText.isUserInteractionEnabled=false
        self.editButtonToHide.isHidden=false
        
    }
    

    //Done button
    @IBAction func doneEditprofile(_ sender: Any) {
        
         let db = Firestore.firestore() // refrence to the firebase obj
       
        print("uid333//////")
        //update database:
        guard let userID = Auth.auth().currentUser?.uid else {
        return }
        //set entire document with same uid, this is an update way
        db.collection("users").document(userID).setData([
            "ChildName": self.ChildNameTextField.text! ,
            "ChildAge": self.ChildAgeTextField.text! ,
            "CarName": self.CarNameTextField.text! ,
            "FavoriteHobby" :self.ChildHobbyTextField.text!,
            "Bio": self.bioText.text!]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    let alert = UIAlertController(title: "", message: "updated successfully", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        let storyboard = self.storyboard?.instantiateViewController(identifier: "HomeVC2") as! AfterpressLogin
                                           
                        self.navigationController?.pushViewController(storyboard, animated: true)
                        storyboard.navigationItem.hidesBackButton = true
                    }
                                  alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    self.updateFeilds() // call to save to database
                }//edn else
            }//end error
        
        //disable feilds again
        disableFeilds() //doesn't work to un hide edit
        print("feild disabled?")
         self.editButtonToHide.isHidden=false
        self.editButtonToHide.isUserInteractionEnabled=true
        
        self.doneButtonToHide.self.isHidden=true
         print("feild disabled?")
    }// end func
    
    
    //to slove the snapshot problem : //suggested
    func updateFeilds(){
                  let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
               return }
        
        db.collection("users").document(userID)
        .addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
          guard let data = document.data() else {
            print("Document data was empty.")
            return
          }
           self.ChildNameTextField.text = data["ChildName"] as? String
            self.ChildAgeTextField.text =  "\(data["ChildAge"] ?? "" )"
            self.CarNameTextField.text = data["CarName"] as? String
            self.ChildHobbyTextField.text = data["FavoriteHobby"] as? String
            self.bioText.text = data["Bio"]as? String
        }
        
    }//end update feild
   
    
    //Log out
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
    
    
    
    //child name
    @objc func validateName(textfield: UITextField) -> Bool {
          
        if( ChildNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            errorLabel.text=" please Enter Name"
            return false
        }//end if
        else {
            errorLabel.text="" //no error
            return true
        }//end else
      }//end method
    
    
    //Hobby
    @objc func validateHobby(textfield: UITextField) -> Bool {
    
    if(ChildHobbyTextField.text?.count ?? 0 <= 0){
          errorLabel.text=" please Enter Hobby"
          return false
      }//end if
      else {
          errorLabel.text="" //no error
          return true
      }//end else
    }//end method
    
    
    
    //Age
    @objc func validateAge(textfield: UITextField) -> Bool {
       
      //var agecheck = Int(ChildAgeTextField.text) == 0 number or no ?
        
        if(ChildAgeTextField.text?.count ?? 0 <= 0) {
             errorLabel.text=" please Enter Age"
             return false
         }//end if
         else {
             errorLabel.text="" //no error
             return true
         }//end else
       }//end method
    
    
//car name
    @objc func validateCarName(textfield: UITextField) -> Bool {
       
       if(CarNameTextField.text?.count ?? 0 <= 0){
             errorLabel.text=" please Enter CarName"
             return false
         }//end if
         else {
             errorLabel.text="" //no error
             return true
         }//end else
       }//end method
    
    
    
    
    
    
}
