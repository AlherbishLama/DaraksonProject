//
//  FifthPartRegisteration.swift
//  Home
//
//  Created by Lama Alherbish on 2/4/20.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import Foundation
import UIKit

class FifthPartRegisteration : UIViewController {
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
      }
    
    
    
    @IBAction func DoneFromRegesteration(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: statics.HomeViewController) as! HomeController
                                                       
        self.navigationController?.pushViewController(storyboard, animated: true)
        storyboard.navigationItem.hidesBackButton = true
    }
    
    
}
