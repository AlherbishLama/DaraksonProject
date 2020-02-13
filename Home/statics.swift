//
//  statics.swift
//  Home
//
//  Created by Lama Alherbish on 1/31/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit

class statics {
    
    static let HomeViewController = "HomeVC"
    static let NavViewController = "Nav"
    static let SecondPartRegestration = "RegisterPart2"
    static let ThirdPartRegestration = "RegisterPart3"
    static let FourthPartRegisteration = "RegisterPart4"
    static let FifthPartRegisteration = "RegisterPart5"
    
    static let ResetPasswordView = "ForgotPassword"
    static let LoginView = "LoginVC"
    
    
    
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }//end of the method
    
    
    
}
