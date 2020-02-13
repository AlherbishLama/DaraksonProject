//
//  thirdPartRegisteration.swift
//  Home
//
//  Created by Lama Alherbish on 2/3/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import  UIKit

class thirdPartRegisteration : UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var FavoritHobbyTextField: UITextField!
    
    
    @IBOutlet weak var NextButtonToTheRegisterPart4: UIButton!
    
    struct globel3{
      static var email = String()
      static var FavoritHobby = String()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0
        EmailTextField.delegate = self
        FavoritHobbyTextField.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if textField == FavoritHobbyTextField {
              let allowCharacters = CharacterSet.letters // to restrict the user to enter only letters
              let characterSet = CharacterSet(charactersIn: string)
            return allowCharacters.isSuperset(of: characterSet) }
           else if textField == EmailTextField {
           var allowCharacters = CharacterSet()
            allowCharacters.formUnion(.letters)
            allowCharacters.formUnion(.punctuationCharacters)
            allowCharacters.formUnion(.decimalDigits)
            let characterSet = CharacterSet(charactersIn: string)
            return allowCharacters.isSuperset(of: characterSet)
        }
        return false
           
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
     
     if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  FavoritHobbyTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
         return "please fill the field."
     } //it will remove all spaces and lines
     
     else{
        globel3.email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if statics.isValidEmail(globel3.email) == false {
            return "Please enter a valid email"
            
        }
               globel3.FavoritHobby = FavoritHobbyTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
     return nil
     }}
    
    @IBAction func Next(_ sender: Any) {
        
        //validate
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
    
}
