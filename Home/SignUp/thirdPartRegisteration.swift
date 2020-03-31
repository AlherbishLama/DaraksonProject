//thirdPartRegisteration.swift
//  Home
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refactor Status : Completed.---------------------------------------------
// Importing essintial dependencies and freamworks here
import Foundation // provides the NSObject root class
import  UIKit // for UI object
import UserNotifications // will have to request permission from the user to recive Notification.

//-----------------------------start of the class---------------------------------------------------------
class thirdPartRegisteration : UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var FavoritHobbyTextField: UITextField!
    @IBOutlet weak var NextButtonToTheRegisterPart4: UIButton!
// to use in other storyboards.
    struct globel3{
      static var email = String()
      static var FavoritHobby = String()
    }
 //------------------------------viewDidLoad()-----------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0
        EmailTextField.delegate = self
        FavoritHobbyTextField.delegate = self
        if HomeController.globalNotification.DidAllow1 == true {
             let content = UNMutableNotificationContent()
             content.title = "Don't forget to complete the registeration"
             content.badge = 1
             let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
             let request = UNNotificationRequest(identifier: "registeration", content: content, trigger: trigger)
             UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                                                }
    }
//--------------------------validate fields & restrict the user to enter only letters-----------------------------------
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if textField == FavoritHobbyTextField {
                let allowCharacters = CharacterSet.letters
                let characterSet = CharacterSet(charactersIn: string)
            return allowCharacters.isSuperset(of: characterSet)
           } else if textField == EmailTextField {
                 var allowCharacters = CharacterSet()
                allowCharacters.formUnion(.letters)
                allowCharacters.formUnion(.punctuationCharacters)
                allowCharacters.formUnion(.decimalDigits)
                let characterSet = CharacterSet(charactersIn: string)
            return allowCharacters.isSuperset(of: characterSet)
           }
            return false
        }
//---------------------------------------KeyBoardHiding---------------------------------------------------
    
          func textFieldShouldReturn(_ textField: UITextField) -> Bool {
              textField.resignFirstResponder()
              return true
          }
          // to hide the keyboard when the user preeses outside
          override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
              self.view.endEditing(true)
          }
    
  //----------remove all spaces and lines then validate if all fields are filled-----------------------------------
    func validateTextField () -> String? {
     if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  FavoritHobbyTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill the field."
       }else {
        globel3.email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if statics.isValidEmail(globel3.email) == false {
            return "Please enter a valid email"
        }
               globel3.FavoritHobby = FavoritHobbyTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            return nil
        }
        
    }
    
//----------------------------------------only move next when no error----------------------------------------------
    @IBAction func Next(_ sender: Any) {
       let error = validateTextField()
       if error != nil { //that's means that there's an error
            ErrorLabel.text = error!
            ErrorLabel.alpha = 1
            NextButtonToTheRegisterPart4.isEnabled = true
       } else {
        
          let storyboard = self.storyboard?.instantiateViewController(identifier: statics.FourthPartRegisteration) as! FourthPartRegisteration
          self.navigationController?.pushViewController(storyboard, animated: true)
       }
    }
//------------------------------------end of class---------------------------------------------
    
}
