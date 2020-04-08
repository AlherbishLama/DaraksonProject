//  GussMyMovie.swift
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Completed-----------------------------------------------

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
