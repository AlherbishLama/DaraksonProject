//  FifthPartRegisteration.swift
//  Home
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refactor Status : Completed---------------------------------------------
import Foundation // provides the NSObject root class
import UIKit // for UI object

//-----------------------------start of the class---------------------------------------------------------
class FifthPartRegisteration : UIViewController {
    
//------------------------------viewDidLoad()-----------------------------------------------

    override func viewDidLoad() {
          super.viewDidLoad()
      }
//------------------------------changeViewAfterRegister-----------------------------------------------
    @IBAction func DoneFromRegesteration(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: statics.HomeViewController) as! HomeController
                                                       
        self.navigationController?.pushViewController(storyboard, animated: true)
        storyboard.navigationItem.hidesBackButton = true
    }
//------------------------------------end of class---------------------------------------------
}
