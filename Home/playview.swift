//
//  playview.swift
//  Home
//
//  Created by Lama Alherbish on 08/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

import UIKit
import CocoaMQTT
import AVKit


class playview: UIViewController , UIWebViewDelegate {
    //172.20.10.12 //1883
 let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "192.168.100.79", port: 49198)
    @IBOutlet weak var Maxbutton: UIButton!
    @IBOutlet weak var buttombutton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var rightbutton: UIButton!
    
    @IBOutlet weak var Topbutton: UIButton!
    
    @IBOutlet weak var leftbutton: UIButton!
    
    @IBOutlet weak var Minbutton: UIButton!

    @IBAction func backsprint1(_ sender: UIButton) {
        
        if sender.isSelected {
                   mqttClient.publish("rpi/gpio", withString: "blink")
               }
               else {
                   mqttClient.publish("rpi/gpio", withString: "off")
               }
   }
//
    override func viewDidLoad() {
        super.viewDidLoad()
// Do any additional setup after loading the view.
      //  videoWebView.loadRequest(URLRequest(url: URL(string: "http://192.168.100.82:8160")!))
        
        let stream_uri = "http://192.168.100.82:8160"

        webView.delegate = self
        if let url = URL(string: stream_uri) {
            webView.loadRequest(URLRequest(url: url))
        }

    }
    
   

    
    
    @IBAction func connect(_ sender: UIButton) {  mqttClient.connect()

    }
   
    
    @IBAction func con(_ sender: Any) {
    }

    @IBAction func Topbutton(_ sender: UIButton) {
         mqttClient.publish("rpi/move", withString: "Top")
    }
    @IBAction func connadlamp(_ sender: UISwitch) {


        if sender.isOn {
                mqttClient.publish("rpi/gpio", withString: "blink")
            }
            else {
                mqttClient.publish("rpi/gpio", withString: "off")
            }
    }


    @IBAction func Leftbutton(_ sender: UIButton) {
          mqttClient.publish("rpi/move", withString: "Left")
    }
    @IBAction func backButton(_ sender: UIButton) {
         mqttClient.publish("rpi/move", withString: "Back")
    }

    @IBAction func RightButton(_ sender: UIButton) {
         mqttClient.publish("rpi/move", withString: "Right")
    }
    @IBAction func Maxbutton(_ sender: Any) {
        
    }
    
    
    
    @IBAction func Minbutton(_ sender: Any) {
    }
    
    /*
     @IBAction func Maxbutton(_ sender: Any) {
     }
      MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
