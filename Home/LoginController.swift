//
//  LoginController.swift
//  Home
//
//  Created by Lama Alherbish on 1/30/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import UIKit
import FirebaseAuth
import UserNotifications

class LoginController:UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0 //to hide the lable
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    //alphanumerics
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField {
           let allowCharacters = CharacterSet.decimalDigits // to restrict the user to enter only numbers
           let characterSet = CharacterSet(charactersIn: string)
           var startString = ""
           
           if textField.text != nil {
               startString += textField.text!
           }

           startString += string

            var limitNumber = Int(startString) ?? 0

           if limitNumber > 999999 || limitNumber == 0{
               return allowCharacters.isSuperset(of: characterSet) && false

           } else {
               return allowCharacters.isSuperset(of: characterSet) && true

            }} else if textField == emailTextField {
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
              
              if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                  return "please fill all fields."
              } //it will remove all spaces and lines
           
        
           let emailToBeCheck = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                 if statics.isValidEmail(emailToBeCheck) == false {
                            return "Please enter a valid email"
                            
                        }
        
           return nil
           
       }
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
               
        self.activityIndicator.startAnimating()
        emailTextField.isEnabled = false
        passwordTextField.isEnabled = false
        loginButton.isEnabled = false
               
        // validate text fields
        let error = validateTextField()
                      
        if error != nil { //that's means that there's an error
            errorLabel.text = error!
            errorLabel.alpha = 1
            emailTextField.isEnabled = true
            passwordTextField.isEnabled = true
            loginButton.isEnabled = true
            self.activityIndicator.stopAnimating()
               } else {
                      
                 let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
                          
        //signin the user
                       
           Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                           
                           
        if error != nil {
            self.activityIndicator.stopAnimating()
            self.errorLabel.text = "The combination of email and password is incorrect"
            self.errorLabel.alpha = 1
            self.emailTextField.isEnabled = true
            self.passwordTextField.isEnabled = true
            self.loginButton.isEnabled = true
                } else {
            if Auth.auth().currentUser!.isEmailVerified == false {
                        self.activityIndicator.stopAnimating()
                        let alert = UIAlertController(title: "Alert", message: "Please verify your email", preferredStyle: UIAlertController.Style.alert)
                                           
                                           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                                               alert.dismiss(animated: true, completion: nil)
                                           }))
                                           
                                           self.present(alert, animated: true ,completion: nil )
                self.loginButton.isEnabled = true
                        let storyboard = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeController
                                           
                self.navigationController?.pushViewController(storyboard, animated: true) }
            else {
                               //transmit to Home page
           // self.activityIndicator.stopAnimating()
                  let storyboard = self.storyboard?.instantiateViewController(identifier: "HomeVC2") as! AfterpressLogin
                               
            self.navigationController?.pushViewController(storyboard, animated: true)
                               
          //self.view.window?.rootViewController = storyboard
                               
            // self.view.window?.makeKeyAndVisible() //it will show that the home controller is the root
            storyboard.navigationItem.hidesBackButton = true
            //storyboard.navigationItem.rightBarButtonItem =
                           }
                       }
                         
            }
        }
           }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: statics.ResetPasswordView) as! ResetPassword
                                      
                   self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
           
    
}
