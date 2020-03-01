//
//  ResetPassword.swift
//  Home
//
//  Created by Lama Alherbish on 2/5/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import UIKit
import Firebase

class ResetPassword : UIViewController  , UITextFieldDelegate{
    
    
    @IBOutlet weak var ResetEmail: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0 //to hide the lable
        ResetEmail.delegate = self
     
    }
    
    //Presses return key to hide the key board
          func textFieldShouldReturn(_ textField: UITextField) -> Bool {
              textField.resignFirstResponder()
              return true
          }
          // to hide the keyboard when the user preeses outside
          override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
              self.view.endEditing(true)
          }
    

    
    
    @IBAction func ResetPassword(_ sender: Any) {
        
        if ResetEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || statics.isValidEmail(ResetEmail.text!) == false {
            ErrorLabel.alpha = 1
            ErrorLabel.text = "Please enter a valid email"
        } else {
            Auth.auth().sendPasswordReset(withEmail: ResetEmail.text!) { error in
                
                if error != nil {
                    self.ErrorLabel.alpha = 1
                    self.ErrorLabel.text = "There was a problem in sending a reset email"
                } else {
                    statics.alert(message: "Please check your email to reset your password", title: "Alert", view: self)
                    

                }
          
        }
    }
    
    
}
}

