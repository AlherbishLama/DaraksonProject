//  statics.swift
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status :Completed-----------------------------------------------
import Foundation // provides the NSObject root class
import UIKit // for UI object
import Firebase

class statics {
    
    static let HomeViewController = "HomeVC"
    static let NavViewController = "Nav"
    static let SecondPartRegestration = "RegisterPart2"
    static let ThirdPartRegestration = "RegisterPart3"
    static let FourthPartRegisteration = "RegisterPart4"
    static let FifthPartRegisteration = "RegisterPart5"
    static let ResetPasswordView = "ForgotPassword"
    static let LoginView = "LoginVC"
    static var childName = ""
    static var childAge = ""
    static var childHobby = ""
    static var childBio = ""
    static var carName = ""
    static var childLevel = ""
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }//end of the method
    
    
    static func alert( message: String , title: String , view: UIViewController){
          let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
                                       
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                            alert.dismiss(animated: true, completion: nil)
                                       }))
                                       
        view.present(alert, animated: true ,completion: nil )
    }
    
    static func integer(from textField: UITextField) -> Int {
        guard let text = textField.text, let number = Int(text) else {
            return 0
        }
        return number
    }
    
    static func setFields() -> Bool{
           let current = Auth.auth().currentUser?.uid

       Database.database().reference().child("users").child(current!).observe(.value) { (snapshot) in
           
           let s = snapshot.value as? [String:String]
           childName = s!["Child_Name"]!
        profileController.childName = childName
           print("============="+childName)
           carName = s!["Car_Name"]!
        profileController.carName = carName
           print("============="+carName)
           childAge = s!["Child_Age"]!
        profileController.childAge = childAge
           print("============="+childAge)
           childBio = s!["Bio"]!
        profileController.childBio = childBio
           print("============="+childBio)
           childHobby = s!["Favorit_Hobby"]!
        profileController.childHobby = childHobby
           print("============="+childHobby)
           childLevel = s!["Level"]!
           print("============="+childLevel)

           
           }
        return true ;
       }

    
}
