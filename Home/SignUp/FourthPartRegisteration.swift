// FourthPartRegisteration.swift
//  Home
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refactor Status : Not Completed---------------------------------------------
// Importing essintial dependencies and freamworks here
import UIKit // for UI object
import Firebase // for linking the project with firebase.
import FirebaseAuth // Pod for User Authintication from Firebase.
import UserNotifications // will have to request permission from the user to recive Notification.

//-----------------------------start of the class---------------------------------------------------------
class FourthPartRegisteration : UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var NextButtonToTheRegisterPart5: UIButton!
    @IBOutlet weak var ChildNameTextField: UITextField!
    @IBOutlet weak var ChildAgeTextField: UITextField!
    // Varialbles :
    var Email = thirdPartRegisteration.globel3.email
    var password = SecondPartRegisteration.globel2.completePassword
    var FavoritHobby = thirdPartRegisteration.globel3.FavoritHobby
    var CarName = SignUpController.global1.carName
   //------------------------------viewDidLoad()-----------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0
        ChildAgeTextField.delegate = self
        ChildNameTextField.delegate = self
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
            if textField == ChildAgeTextField {
               let allowCharacters = CharacterSet.decimalDigits// to restrict the user to enter only numbers
             //   textField.Ran
               let characterSet = CharacterSet(charactersIn: string)
                    return allowCharacters.isSuperset(of: characterSet)
            } else {
                let allowCharacters = CharacterSet.letters // to restrict the user to enter only alpha
                let characterSet = CharacterSet(charactersIn: string)
                return allowCharacters.isSuperset(of: characterSet)
            }
        }
        
//---------------------------------------KeyBoardHiding---------------------------------------------------
        //Presses return key to hide the key board
              func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                  textField.resignFirstResponder()
                  return true
              }
              // to hide the keyboard when the user preeses outside
              override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                  self.view.endEditing(true)
              }
//----------remove all spaces and lines then validate if all fields are filled and validate Age-----------------------------------
        
        func validateTextField () -> String? {
            //it will remove all spaces and lines
            if ChildNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  ChildAgeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "please fill the field."
            } else if (statics.integer(from: ChildAgeTextField)) < 9 {
                return "The application is designed for kids from 9 and older"
            }else if (statics.integer(from: ChildAgeTextField)) > 50{
                return "Age is unrealistic , please enter again"
            } else{
                return nil
            }
    }
     
 // Till here . the following needs refactoring :
  
    @IBAction func Next(_ sender: Any) {
        //validate
          let error = validateTextField()
          if error != nil { //that's means that there's an error
          ErrorLabel.text = error!
          ErrorLabel.alpha = 1
          NextButtonToTheRegisterPart5.isEnabled = true
         } else {
               if Email != ""{
                print(Email)
               }else {
                print("fff")
               }
        //create user
        Auth.auth().createUser(withEmail: Email, password: password) { (result, err) in
        //check for errors
        if err != nil {
        //there was an error Creating the user
        self.ErrorLabel.text = "error in creating user"
        print("error in creating user")
        self.ErrorLabel.alpha = 1
                    } else {
        print("user was created successfully, now we have to store the data of the user")
        let ref = Database.database().reference().root  //Global Variable
        let childName = self.ChildNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let childAge = Int(self.ChildAgeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        // following same structure in Database Scheema.
        ref.child("users").child((result?.user.uid)!).setValue(["Child_Name" : childName , "Child_Age" : "\(childAge)" , "Car_Name" : self.CarName , "Favorit_Hobby": self.FavoritHobby , "Bio": ""] )
            { (err, reff) in
            if err != nil {
                self.ErrorLabel.text = "TRY AGAIN LATER , couldn't save your data"
                self.ErrorLabel.alpha = 1
                let storyboard = self.storyboard?.instantiateViewController(identifier: statics.HomeViewController) as! HomeController
                self.navigationController?.pushViewController(storyboard, animated: true)
            }else{
                Auth.auth().currentUser?.sendEmailVerification(completion: { (err) in
                        guard let err = err else{
                        statics.alert(message: "user email verification sent", title: "Alert", view: self)
                        return print("NO ERROR")
                    }
                    statics.alert(message: "couldn't send email verification , Try Again", title: "Alert", view: self)
                })
                let storyboard = self.storyboard?.instantiateViewController(identifier: statics.FifthPartRegisteration) as! FifthPartRegisteration
                self.navigationController?.pushViewController(storyboard, animated: true)
            }
          }
       }
     }
   }
}// end next
//------------------------------------end of class---------------------------------------------
    
    }
