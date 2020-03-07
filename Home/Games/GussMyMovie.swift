//
//  GussMyMovie.swift
//  Home
//
//  Created by Lama Alherbish on 02/03/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//  Adding the mqtt to the code

import UIKit
import CocoaMQTT

class GussMyMovie: UIViewController {
    
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.20.10.12", port: 1883)
    
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBAction func No(_ sender: Any) {
        mqttClient.publish("GMM", withString: "n")
        print("No")
    }
    
    @IBAction func Yes(_ sender: Any) {
        mqttClient.publish("GMM", withString: "y")
        print("Yes")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mqttClient.connect()
           //I need to add the publish
    }
}
