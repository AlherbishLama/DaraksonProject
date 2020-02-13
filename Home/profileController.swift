//
//  profileController.swift
//  Home
//
//  Created by Lama Alherbish on 08/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class profileController: UIViewController {
    
    @IBOutlet weak var ChildNameLabel: UILabel!
    @IBOutlet weak var ChildHobby: UILabel!
    @IBOutlet weak var ChildAgeLabel: UILabel!
    @IBOutlet weak var CarNameLabel: UILabel!
   // @IBOutlet weak var BioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                                    self.ChildNameLabel.text = all["ChildName"] as? String
                                    self.ChildAgeLabel.text =  "\(all["ChildAge"] ?? "" )"
                                    self.CarNameLabel.text = all["CarName"] as? String
                                    self.ChildHobby.text = all["FavoriteHobby"] as? String
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
