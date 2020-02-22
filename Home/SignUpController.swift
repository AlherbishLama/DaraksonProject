//
//  SignUpController.swift
//  Home
//
//  Created by Lama Alherbish on 1/31/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import UserNotifications

class SignUpController: UIViewController , UITextFieldDelegate{
    
   
    @IBOutlet weak var CarNameTextField: UITextField!
    
    @IBOutlet weak var NextButtonToTheRegisterPart2: UIButton!
  
    @IBOutlet weak var ErrorLabel: UILabel!
    
    struct global1{
        static var carName = String()
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0
        CarNameTextField.delegate = self
        
        if HomeController.globalNotification.DidAllow1 == true {
             let content = UNMutableNotificationContent()
             content.title = "Don't forget to complete the registeration"
             content.badge = 1
             let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
             let request = UNNotificationRequest(identifier: "registeration", content: content, trigger: trigger)
             UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
             
             let allowCharacters = CharacterSet.letters // to restrict the user to enter only alpha
             let characterSet = CharacterSet(charactersIn: string)
                 return allowCharacters.isSuperset(of: characterSet)
           
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
    
    
    
    func validateTextField () -> String? {
        
        if CarNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill the field."
        } //it will remove all spaces and lines
        
        else{
         global1.carName = CarNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        return nil
        }}
    
    
    
    
    @IBAction func Next(_ sender: Any) {
        
        //validate
        let error = validateTextField()
        
        if error != nil { //that's means that there's an error
            ErrorLabel.text = error!
            ErrorLabel.alpha = 1
            NextButtonToTheRegisterPart2.isEnabled = true
        } else {
        
            let storyboard = self.storyboard?.instantiateViewController(identifier: statics.SecondPartRegestration) as! SecondPartRegisteration
                                        
                     self.navigationController?.pushViewController(storyboard, animated: true)
        }
      
    
    
}
}
