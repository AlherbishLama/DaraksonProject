//  SignUpController.swift
//  Home
//  Copyright © 2020 Darakson. All rights reserved.
//------------------------Refactor Status : Completed.---------------------------------------------
// Importing essintial dependencies and freamworks here
import UIKit // for UI object
import FirebaseAuth // Pod for User Authintication from Firebase.
import Firebase // for linking the project with firebase.
import UserNotifications // will have to request permission from the user to recive Notification.

//-------------------------------start of the class---------------------------------------------
class SignUpController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var CarNameTextField: UITextField! //recive car name from the user.
    @IBOutlet weak var NextButtonToTheRegisterPart2: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    // to use in other storyboards.
    struct global1{
        static var carName = String()
        }
//--------------------------------viewDidLoad()-----------------------------------------------
    
    override func viewDidLoad() { //start of func
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
    }//end of viewDidLoad()
//------------------------ to restrict the user to enter only alpha----------------------------------
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
             let allowCharacters = CharacterSet.letters
             let characterSet = CharacterSet(charactersIn: string)
                 return allowCharacters.isSuperset(of: characterSet)
             } // end of textField()
//-----------------------------Presses return key to hide the key board---------------------------------
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//---------------------------------to hide the keyboard when the user preeses outside--------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//-------------------------it will remove all spaces and lines then validate-------------------------------------------
    
    func validateTextField () -> String? {
        if CarNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill the field."
        }
        else{
         global1.carName = CarNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        return nil
        }}
//----------------------------validate------------------------------------------------------------------

    @IBAction func Next(_ sender: Any) {
        let error = validateTextField()
        if error != nil { //that's means that there's an error
            ErrorLabel.text = error!
            ErrorLabel.alpha = 1
            NextButtonToTheRegisterPart2.isEnabled = true
        } else {
            let storyboard = self.storyboard?.instantiateViewController(identifier: statics.SecondPartRegestration) as! SecondPartRegisteration
                     self.navigationController?.pushViewController(storyboard, animated: true)
        } //else
    }// end of Next()
    
  //------------------------------------end of class---------------------------------------------
}
