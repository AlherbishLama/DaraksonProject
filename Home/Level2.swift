//
//  Level2.swift
//  Home
//
//  Created by  Hanen Alkhalf on 26/07/1441 AH.
//  Copyright © 1441 Lama Alherbish. All rights reserved.
//

import UIKit
import AVFoundation
import UIKit.UIFont
import CocoaMQTT


class CircleView2:UIView{
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        let radius: Double  = 40
      
        let center = CGPoint(x: 40, y: rect.height / 2)
        path.move(to: CGPoint(x: center.x + CGFloat(radius), y: center.y ))
        
        for i in stride(from: 0, to: 361.0, by: 8){
            let radians = i * Double.pi / 100
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
        
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        UIColor.init(red: 99/255, green: 73/255, blue: 71/255, alpha:1.0).setFill()
        path.fill()
    }
    
}

class CView2:UIView{
    let path = UIBezierPath()
    override func draw(_ rect: CGRect) {
        let radius: Double  = 15
      
        let center = CGPoint(x: 40, y: rect.height / 2)
        path.move(to: CGPoint(x: center.x + CGFloat(radius), y: center.y ))
        
        for i in stride(from: 0, to: 361.0, by: 8){
            let radians = i * Double.pi / 100
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
        
            path.addLine(to: CGPoint(x: x, y: y))
        }
        UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).setFill()
        path.fill()
    }
    
}


class Level2: UIViewController,UITextFieldDelegate {
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.20.10.12", port: 1883)

    @IBOutlet weak var Start2: UIButton!
    
    @IBOutlet weak var cloudbubble: UIImageView!
    
    
    @IBOutlet weak var gonext2: UIButton!
    
   // @IBOutlet weak var trying2: UIButton!
    
    
    @IBOutlet weak var youcan: UITextField!
    
    
    @IBOutlet weak var run: UIButton!
    
    
    @IBOutlet weak var happycloud: UIImageView!
    
    @IBOutlet weak var youdidit: UILabel!
    
    @IBOutlet weak var arrowright: UIImageView!
    
    @IBOutlet weak var arrowlift: UIImageView!
    @IBOutlet weak var notdidit: UILabel!
    

    @IBOutlet weak var FFinsh: UIButton!
    
    @IBOutlet weak var talk: UILabel!
    
    
    var audioPlayer : AVAudioPlayer?
    
    var storyLine: [String] = ["Now, we will learn how to use loop!",
                               "Remember when you used the print() statement?",
                                 "Let’s say you wanted to greet your car 10 times","then, you have to write print() 10 times too",
                                 "but with the use of loop, you select the number of times to repeat itself","with your message inside the print()!!",
                                 "Depends on the number you enter; your car will turn around just like loops!",
                                 "If you enter 2, the loop will work for 2 turns, try it!",
                                 "Enter the number of loops"]
    var line = 0
    
    
    @IBAction func FFinshh(_ sender: UIButton) {
        levell2 = true
        LockimagArr[3] = ""
    }
    
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //   Find out what the text field will be after adding the current edit
        
        //self.run.alpha = 1.0
        //rrun(run)
        let text = CharacterSet.decimalDigits
        let l = CharacterSet(charactersIn: string)
        self.run.alpha = 1.0
        return text.isSuperset(of: l)

     }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
           textField.resignFirstResponder()
           return true
       }

    
    @IBAction func rrun(_ sender: UIButton) {
        //mqttClient.connect()
             self.animateButton(sender)
             print(String(self.youcan.text!))
             UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
                 self.happycloud.alpha = 1.0
                 //Changed here
                 if self.youcan.text == "" {
                   self.notdidit.alpha = 0.0
                   self.youdidit.alpha = 1.0
                 }
                 else{
                     UIView.animate(withDuration: 0.4, delay: 0.4, options: .curveEaseOut, animations: {
                        print("inside")
                        self.notdidit.alpha = 1.0
                        self.youdidit.alpha = 0.0
                        self.FFinsh.alpha = 1.0
                        self.FFinsh.alpha = 1.0
                        levell2 = true
                         
                                   
                     })
                 }
             })
             
             mqttClient.publish("lvl/0", withString: String(youcan.text!))
    }
    
    @IBAction func next(_ sender: UIButton) {
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseOut, animations: {
                       self.gonext2.alpha = 0.0
                   })
                   self.animateButton(sender)
                   talk.text = ""
                   talk.font = talk.font.withSize(18)
                   RunLoop.current.run(until: Date() + 0.5)
                   appearNext()
                   animateText(words: storyLine[line])
                   self.line = self.line + 1
                   if line > 7{
                       self.gonext2.alpha = 0.0
                       UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
                       self.cloudbubble.alpha = 0.0
                       self.talk.alpha = 0.0
                       self.youcan.alpha = 1.0
                       self.arrowright.alpha = 1.0
                       self.arrowlift.alpha = 1.0
            //         self.run.alpha = 1.0
                       })
                    
                    
                            
                   }
        
    }
    
    
    @IBAction func thefirstone(_ sender: UIButton) {
        if Start2.alpha == 1.0{
                  sound()
                  self.animateButton(sender)
                  fade()
                  appearcloud()
                  RunLoop.current.run(until: Date() + 4.0)
                  appearNext()
                  talk.font = talk.font.withSize(18)
                  animateText(words: storyLine[line])
                  self.line = self.line + 1
            }
    }
    
   func fade(){
        UIView.animate(withDuration: 1.5, delay: 0.4, options: .curveEaseOut, animations: {
                self.Start2.alpha = 0.0
        })
    }
    
    func appearNext(){
        if line >= 7{
                   self.gonext2.alpha = 0.0
        }
        else if gonext2.alpha == 0.0{
                
        UIView.animate(withDuration: 0.1, delay: 8.9, options: .curveEaseOut, animations: {
                    self.gonext2.alpha = 1
            })
        }
    }
    
    func appearcloud(){
       if cloudbubble.alpha == 0.0{
               
       UIView.animate(withDuration: 0.4, delay: 3.0, options: .curveEaseOut, animations: {
               self.cloudbubble.alpha = 1
                   
       })
       }else{
           UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                   self.cloudbubble.alpha = 0.0
               })
           }
       }
    
    func sound(){
        let pathsound = Bundle.main.path(forResource: "B", ofType: "wav")!
        let url = URL(fileURLWithPath: pathsound)
            
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }catch{
            print("Audio error")
        }
    }
    
    func animateButton(_ viewA: UIView){
           UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                   
                   viewA.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)

               }){(_) in }
           UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.5, options: .curveEaseIn, animations: {
                                 
                   viewA.transform = CGAffineTransform(scaleX: 1, y: 1)
               }, completion: nil)
           }
    
    func animateText(words: String){
        //audioPlayer?.setVolume(0.5, fadeDuration: 0.5)
        
        for i in words{
           
            AudioServicesPlaySystemSound(1306)
           
            talk.text! += "\(i)"
            RunLoop.current.run(until: Date() + 0.18)
            
        }
    }
    
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mqttClient.connect()
        youcan.delegate = self

        // the background of the view
        let backview = UIView()
        backview.frame.size = CGSize(width: 500, height: 1000)
        backview.center = view.center
        view.addSubview(backview)
        
        // Animating the background to move
        let gradient = CAGradientLayer(layer: backview.layer)
        gradient.colors = [UIColor.init(red: 181/255, green: 220/255, blue: 255/255, alpha: 1.0).cgColor ,UIColor.init(red: 255/255, green: 198/255, blue: 181/255, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:0, y:1.0)
        gradient.frame = backview.bounds
        gradient.locations = [0, 0.6]
        backview.layer.insertSublayer(gradient, at: 0)
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0, 0.6]
        animation.toValue = [0, 2]
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.speed = 0.2
        gradient.add(animation, forKey: nil)
            
            super.viewDidLoad()
        //Head of Mr.Robot
        let head = UIView(frame: CGRect(x: 94, y: 300, width:240, height:180 ) )
        head.backgroundColor = UIColor.init(red: 206/255, green: 236/255, blue: 242/255, alpha: 1.0)
        view.addSubview(head)
            
        //head details
        let cap = UIView(frame: CGRect(x: 150, y: 290, width:100, height: 10 ) )
        cap.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 107/255, alpha: 1.0)
        view.addSubview(cap)
            
        //neck
        let neck = UIView(frame: CGRect(x: 190, y: 480, width:50, height: 40 ) )
        neck.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 107/255, alpha: 1.0)
        view.addSubview(neck)

        //Neck details
        var x = 485
        for _ in 1...4{
            let stripe = UIView(frame: CGRect(x: 190, y: x, width:50, height: 3 ) )
            stripe.backgroundColor = UIColor.init(red: 224/255, green: 215/255, blue: 215/255, alpha: 1.0)
            x = x + 10
            view.addSubview(stripe)
        }
            
        //Body of Mr.Robot
        let body = UIView(frame: CGRect(x: 87, y: 510, width:255, height:90 ) )
        body.backgroundColor = UIColor.init(red: 206/255, green: 236/255, blue: 242/255, alpha: 1.0)
        view.addSubview(body)
        
        //eyes of Mr.Robot
        let eye1 = CircleView2(frame: CGRect(x: 110, y: 360, width: 100, height: 100 ) )
        eye1.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(eye1)
            
        let eye2 = CircleView2(frame: CGRect(x: 240, y: 360, width: 100, height: 100 ) )
        eye2.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(eye2)
            
        //Eye bling
        let bling1 = CView2(frame: CGRect(x: 90, y: 350, width: 100, height: 100 ) )
        bling1.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(bling1)
            
        let bling2 = CView2(frame: CGRect(x: 220, y: 350, width: 100, height: 100 ) )
        bling2.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(bling2)
        
        
        //Antena
        let antena = UIView(frame: CGRect(x: 170, y: 220, width: 3, height: 70 ) )
        antena.backgroundColor =  UIColor.init(red: 99/255, green: 73/255, blue: 71/255, alpha:1.0)
        view.addSubview(antena)
            
        //Start animating
        blinkeye() //Let Mr.Robot blink!!! ^_~

        Start2.translatesAutoresizingMaskIntoConstraints = false
         
        //I hide all the icons first then let the appear as i want
        cloudbubble.alpha = 0.0
        gonext2.alpha = 0.0
     //   trying2.alpha = 0.0
        youcan.alpha = 0.0
        arrowlift.alpha = 0.0
        arrowright.alpha = 0.0
        run.alpha = 0.0
        happycloud.alpha = 0.0
        
        youdidit.alpha = 0.0
        notdidit.alpha = 0.0
        FFinsh.alpha = 0.0
            
        youcan.delegate = self

        view.addSubview(cloudbubble)
             view.addSubview(gonext2)
             view.addSubview(talk)
      //       view.addSubview(trying2)
             view.addSubview(youcan)
             view.addSubview(arrowlift)
             view.addSubview(arrowright)
             view.addSubview(run)
        
             view.addSubview(happycloud)
             view.addSubview(youdidit)
             view.addSubview(notdidit)
             view.addSubview(FFinsh)
             view.addSubview(Start2)
         }
    
    //The typing field if user touch to exit then save user input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            youcan.resignFirstResponder()
    }
        
    //Mr.Robots Eye blinking, P.s We all blink if you don't the please get that checked
    func blinkeye(){

        //The eyelids blinking ^_^
        let eyeb = UIView(frame: CGRect(x: 50, y: 330, width:90, height:60 ) )
        eyeb.backgroundColor = UIColor.init(red: 206/255, green: 236/255, blue: 242/255, alpha: 1.0)
        view.addSubview(eyeb)
            
        let eyeb2 = UIView(frame: CGRect(x: 100, y: 330, width:90, height:60 ) )
        eyeb2.backgroundColor = UIColor.init(red: 206/255, green: 236/255, blue: 242/255, alpha: 1.0)
        view.addSubview(eyeb2)
            
        let startPoint1 = CGPoint(x: 150, y: 333)
        let endpoint1 = CGPoint(x: 150, y: 395)

        let startPoint2 = CGPoint(x: 280, y: 333)
        let endpoint2 = CGPoint(x: 280, y: 395)
            
        let duration: Double = 1.9
        let animate1 = constructAnimation(starting: startPoint1, ending: endpoint1, duration: duration)
        let animate2 = constructAnimation(starting: startPoint2, ending: endpoint2, duration: duration)

        eyeb.layer.add(animate1, forKey: "position")
        eyeb2.layer.add(animate2, forKey: "position")

    }
    //This is the function that lets the eyelids of Mr.Robot Blink
    func constructAnimation(starting: CGPoint, ending: CGPoint, duration: Double) -> CABasicAnimation{
        let postion = CABasicAnimation(keyPath: "position")
        postion.fromValue = NSValue(cgPoint: starting)
        postion.toValue = NSValue(cgPoint: ending)
        postion.duration = duration
        postion.autoreverses = true
        postion.repeatCount = Float.infinity
        postion.speed = 2.0
        return postion
    } }


 



