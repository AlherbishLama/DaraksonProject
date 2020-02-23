//
//  SecondPartRegisteration.swift
//  Home
//
//  Created by Lama Alherbish on 2/3/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class SecondPartRegisteration : UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var passField1: UITextField!
    
    @IBOutlet weak var passField2: UITextField!
    
    @IBOutlet weak var passField3: UITextField!
    
    @IBOutlet weak var passField4: UITextField!
    
    @IBOutlet weak var passField5: UITextField!
    
    @IBOutlet weak var passField6: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!

    @IBOutlet weak var NextButtonToTheRegisterPart3: UIButton!
    
    struct globel2{
        static var completePassword = String()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0
        passField1.delegate = self
        passField2.delegate = self
        passField3.delegate = self
        passField4.delegate = self
        passField5.delegate = self
        passField6.delegate = self
        
        passField1?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        passField2?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
               
        passField3?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        passField4?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
               
        passField5?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        passField6?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
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
        
        let allowCharacters = CharacterSet.decimalDigits // to restrict the user to enter only numbers
        let characterSet = CharacterSet(charactersIn: string)
        var startString = ""
        
        if textField.text != nil {
            startString += textField.text!
        }

        startString += string

        var limitNumber = Int(startString) ?? 0

        if limitNumber > 9 {
            return allowCharacters.isSuperset(of: characterSet) && false

        } else {
            return allowCharacters.isSuperset(of: characterSet) && true

        }
      
        }
    
    
    @objc func textFieldDidChange(_ textField: UITextField){
           if textField == passField1 {
                      if (textField.text?.count)! == 1 {
                          passField2?.becomeFirstResponder()
                      }
                  }
                  else if textField == passField2 {
                      if (textField.text?.count)! == 1 {
                          passField3.becomeFirstResponder()
                      }
                  } else if textField == passField3 {
                  if (textField.text?.count)! == 1 {
                      passField4.becomeFirstResponder()
               }}else if textField == passField4 {
                  if (textField.text?.count)! == 1 {
                      passField5.becomeFirstResponder()
               }} else if textField == passField5 {
                  if (textField.text?.count)! == 1 {
                      passField6.becomeFirstResponder()//resignFirstResponder()
               }}else if textField == passField6 {
               if (textField.text?.count)! == 1 {
                   passField6.resignFirstResponder()
                   
               }}
           
           
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
    
    if passField1.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passField2.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passField3.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  passField4.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passField5.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passField6.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
           return "please fill the field."
       } //it will remove all spaces and lines
       
       else{
           let p1 = (passField1.text!.trimmingCharacters(in: .whitespacesAndNewlines))
               
               let p2 = passField2.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let p3 = passField3.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let p4 = passField4.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           let p5 = passField5.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           let p6 = passField6.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
           globel2.completePassword = p1 + p2 + p3 + p4 + p5 + p6
           
       return nil
       }}
    
    
    
    @IBAction func Next(_ sender: Any) {
          //validate
                let error = validateTextField()
                
                if error != nil { //that's means that there's an error
                    ErrorLabel.text = error!
                    ErrorLabel.alpha = 1
                    NextButtonToTheRegisterPart3.isEnabled = true
                } else {
                    
                    
                    let storyboard = self.storyboard?.instantiateViewController(identifier: statics.ThirdPartRegestration) as! thirdPartRegisteration
                                                
                             self.navigationController?.pushViewController(storyboard, animated: true)
                }
              
            
            
        
    }
    
    
    
}
