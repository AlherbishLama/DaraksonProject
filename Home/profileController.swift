//
//  profileController.swift
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status :Not Completed----------------------------------------------- 

import Foundation
import UIKit
import Firebase
import UserNotifications



 class profileController: UIViewController {
    
 

   // @IBOutlet weak var BioLabel: UILabel!
    @IBOutlet weak var ChildNameTextField: UITextField!
    @IBOutlet weak var ChildHobbyTextField: UITextField!
    @IBOutlet weak var CarNameTextField: UITextField!
    //bio
    @IBOutlet weak var ChildAgeTextField: UITextField!
    //buttons to hide
    @IBOutlet weak var BioTextFieldView: UITextView!
    @IBOutlet weak var editButtonToHide: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var isValid = true
    var isAllowed = true
    var isValid2 = true
    static var childName = ""
    static var childAge = ""
    static var childBio = ""
    static var childHobby = ""
    static var carName = ""


    

    
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
        
        setFields()
        }
    
    
    func setFields(){
        self.ChildNameTextField.text = profileController.childName
        self.CarNameTextField.text = profileController.carName
        self.ChildAgeTextField.text = profileController.childAge
        self.BioTextFieldView.text = profileController.childBio
        self.ChildHobbyTextField.text = profileController.childHobby
        }
    
       
    
   //_____Edit buttun :
    @IBAction func editProfileTapped(_ sender: Any) {
        self.editButtonToHide.isHidden=true
            self.doneButton.isHidden=false
    
    // show white background and make it editable : editFeildsToWhite()
        editFeildsToWhite( textfield: ChildAgeTextField )
        editFeildsToWhite( textfield: ChildNameTextField )
        editFeildsToWhite( textfield: CarNameTextField )
        editFeildsToWhite( textfield: ChildHobbyTextField )
        
        //bio
        BioTextFieldView.isUserInteractionEnabled = true
        BioTextFieldView.backgroundColor = UIColor.white
    }
    
    
    
    func editFeildsToWhite (textfield: UITextField ){
              textfield.isUserInteractionEnabled = true //enable edit
              textfield.textColor = UIColor.black
              textfield.backgroundColor = UIColor.white
              textfield.borderStyle = UITextField.BorderStyle(rawValue: 2)!
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if textField == CarNameTextField || textField == ChildHobbyTextField || textField == ChildNameTextField || textField == BioTextFieldView || textField == ChildAgeTextField && isAllowed == true{
               let allowCharacters = CharacterSet.letters // to restrict the user to enter only alpha
               let characterSet = CharacterSet(charactersIn: string)
               return allowCharacters.isSuperset(of: characterSet)
           }else {
               let allowCharacters = CharacterSet.decimalDigits// to restrict the user to enter only numbers
                           //   textField.Ran
               let characterSet = CharacterSet(charactersIn: string)
               return allowCharacters.isSuperset(of: characterSet)
           }
       
         }
     
    
    @IBAction func doneAction(_ sender: Any) {
                isvalidTextField(textfield: ChildHobbyTextField)
                isvalidTextField(textfield: ChildAgeTextField)
                isvalidTextField(textfield: CarNameTextField)
                isvalidTextField(textfield: ChildNameTextField)
                isvalidTextView(BioTextFieldView)
                
                if isvalidTextField(textfield: ChildHobbyTextField) == false || isvalidTextField(textfield: ChildAgeTextField) == false || isvalidTextField(textfield: CarNameTextField) == false || isvalidTextField(textfield: ChildNameTextField) == false || isvalidTextView(BioTextFieldView) == false{
                    errorLabel.text = "Please make sure you fill the field with valid data"
                    print("Please make sure you fill the field with valid data")
                }else{
                    let current = Auth.auth().currentUser?.uid
                    Database.database().reference().child("users").child(current!).updateChildValues(["Car_Name": CarNameTextField.text , "Child_Age": "\(ChildAgeTextField.text!)" , "Child_Name": ChildNameTextField.text, "Favorit_Hobby": ChildHobbyTextField.text , "Bio": BioTextFieldView.text ])
                    statics.alert(message: "updated successfully", title: "Alert", view: self)

                    //fields
                    makeFeildsGreyAgain(textfield: ChildAgeTextField )
                    makeFeildsGreyAgain(textfield: ChildNameTextField )
                    makeFeildsGreyAgain(textfield: CarNameTextField )
                    makeFeildsGreyAgain(textfield: ChildHobbyTextField )
               
                   BioTextFieldView.isUserInteractionEnabled = false
                    BioTextFieldView.backgroundColor = UIColor.clear
                    
                    
                    self.doneButton.isHidden = true
                    self.editButtonToHide.isHidden = false
            }
                }// end func
    
    func makeFeildsGreyAgain (textfield: UITextField ){
         textfield.isUserInteractionEnabled = false //enable edit
        textfield.textColor = UIColor.white
        textfield.backgroundColor = UIColor.systemFill
        UITextField.BorderStyle(rawValue: 0)!
    }
     

        
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
    
    
    
    func isvalidTextField(textfield: UITextField) -> Bool{
        //bioTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        if CarNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ChildHobbyTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ChildNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ChildAgeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            print("Empty fields are not allowed")
            errorLabel.text = "Empty fields are not allowed"
            return false
        }else if textfield == ChildAgeTextField {
             if (statics.integer(from: ChildAgeTextField)) < 9 {
                errorLabel.text = "The application is designed for kids from 9 and older"
                print("The application is designed for kids from 9 and older")
                return false
             }else if (statics.integer(from: ChildAgeTextField)) > 50{
                errorLabel.text = "Age is unrealistic , please enter again"
                print("Age is unrealistic , please enter again")

               return false
                
            }
        }
        return true
    }
    
    func isvalidTextView (_ textView : UITextView) -> Bool{
        if BioTextFieldView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            print("Empty fields are not allowed")
            errorLabel.text = "Empty fields are not allowed"
            return false
        }
        return true
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
    
    
    
}
