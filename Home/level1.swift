//
//  level1.swift
//  Home
//
//  Created by Nina on 25/07/1441 AH.
//  Copyright © 1441 Lama Alherbish. All rights reserved.
//

import UIKit
import AVFoundation
import UIKit.UIFont
//-------------------Circle--------------------

class circleView:UIView{

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
class cView:UIView{
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

class level1: UIViewController {

    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var greenbox: UIImageView!
    @IBOutlet weak var level1: UILabel!
    @IBOutlet weak var pinkbox: UIImageView!
    @IBOutlet weak var redbox: UIImageView!
    @IBOutlet weak var yellowbox: UIImageView!
    @IBOutlet weak var lastcloud: UIImageView!
    @IBOutlet weak var start1: UIButton!
    @IBOutlet weak var nextgo: UIButton!
    @IBOutlet weak var dialog: UILabel!
    @IBOutlet weak var dialogcloud: UIImageView!
    
    @IBOutlet weak var skip: UILabel!
    @IBOutlet weak var finsh: UIButton!
    
    var audioPlayer : AVAudioPlayer?
    
    @IBOutlet weak var insidebox: UILabel!
    var words : [String] = []
    
    @IBOutlet weak var runn: UIButton!
    
    @IBOutlet weak var skii: UIButton!
    
    @IBAction func skipp(_ sender: UIButton) {
        nextgo.alpha = 0.0
        skii.alpha = 0.0
        skip.alpha = 0.0
        line = 6
        dialog.text  = ""
        animateText(words: storyLine[line])
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.yellowbox.alpha = 1.0
            self.level1.alpha = 1.0
            self.greenbox.alpha = 0.0
            self.pinkbox.alpha = 0.0
            self.redbox.alpha = 0.0
        })
         
                        
            RunLoop.current.run(until: Date() + 0.5)
            self.dialog.alpha = 0.0
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.dialogcloud.alpha = 0.0
                self.field.alpha = 1.0
                self.counter.alpha = 1.0
                self.lastcloud.alpha = 1.0
                self.storeb.alpha = 1.0
                
            })
    }
    
    @IBAction func empty(_ sender: Any) {
        counter.text = "stored 0"
        count = 0
        words.removeAll()
        //Then hide button
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.runn.alpha = 0.0
            self.field.alpha = 1.0
            self.counter.alpha = 1.0
            self.lastcloud.alpha = 1.0
            self.storeb.alpha = 1.0
            self.insidebox.text = ""
            self.finsh.alpha = 1.0
        })
    }
    var storyLine: [String] = ["Welcome Back, nice to see you!\nLets learn\nabout \"variables\"",
                                  "hmm how do I\nremember your name everytime\nyou log-in?",
                                  "I save all your data \ninside boxes named variables",
                                  "I have a lot of boxes\n different colors and sizes",
                                  "each box belongs to a special\n\"variable\" ^_^",
                                  "this variable name is Level 1\n you can store inside it",
                                  "Try type a word and I will\nstore it inside level 1 variable"
       
    ]
    var line = 0
    var count = 0
    @IBOutlet weak var storeb: UIButton!
    
    @IBAction func storecounter(_ sender: UIButton) {
        if (field.text! != ""){
            if (count < 3){
                count = count + 1
                words.append(field.text!)
                insidebox.text = insidebox.text! + words[count-1] + "\n"
                counter.text = "stored \(count)"
                field.text = ""
            }
            if (count >= 3){
                counter.text = "level 1 is full click\n run to empty "
                UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                           self.runn.alpha = 1.0
                           self.field.alpha = 0.0
                           self.counter.alpha = 1.0
                           self.lastcloud.alpha = 1.0
                           self.storeb.alpha = 0.0
                           
                       })
            }
        }
        
        
    }
    
    

    @IBAction func fefo(_ sender: UIButton) {
        levell1 = true
        LockimagArr[2] = ""
    }
    
    
    
    
// @IBAction func finshh(_ sender: UIButton) {
    //     levell1 = true
    //     LockimagArr[2] = ""
   //  }
 
    
    @IBAction func nextt(_ sender: UIButton) {
        UIView.animate(withDuration: 0.8, delay: 0.3, options: .curveEaseOut, animations: {
                       self.nextgo.alpha = 0.0
                   })
                   self.animateButton(sender)
                   dialog.text = ""
                   dialog.font = dialog.font.withSize(18)
                   RunLoop.current.run(until: Date() + 0.5)
                   appearNext()
                   animateText(words: storyLine[line])
                   self.line = self.line + 1
                   if line > 6{
                       self.nextgo.alpha = 0.0
                    
                    RunLoop.current.run(until: Date() + 0.5)
                    self.dialog.alpha = 0.0
                       UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                        self.dialogcloud.alpha = 0.0
                        self.field.alpha = 1.0
                        self.counter.alpha = 1.0
                        self.lastcloud.alpha = 1.0
                        self.storeb.alpha = 1.0
                        
                       })
                            
                   }
        if line == 3 {
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.yellowbox.alpha = 1.0
        })
        }
        else if line == 4 || line == 5{
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.yellowbox.alpha = 0.0
                self.greenbox.alpha = 1.0
                self.pinkbox.alpha = 1.0
                self.redbox.alpha = 1.0
            })
        }
        else if line == 6 {
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                     self.yellowbox.alpha = 1.0
                     self.level1.alpha = 1.0
                     self.greenbox.alpha = 0.0
                     self.pinkbox.alpha = 0.0
                     self.redbox.alpha = 0.0
                 })
        }
        
    }
    @IBAction func startb(_ sender: UIButton) {
        if start1.alpha == 1.0{
                     sound()
                     self.animateButton(sender)
                     fade()
                     appearcloud()
                     RunLoop.current.run(until: Date() + 4.0)
                     appearNext()
                     dialog.font = dialog.font.withSize(18)
                     animateText(words: storyLine[line])
                     self.line = self.line + 1
            
                skii.alpha = 1.0
                skip.alpha = 1.0
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
    func fade(){
        UIView.animate(withDuration: 1.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.start1.alpha = 0.0
        })
    }
    func appearcloud(){
        if dialogcloud.alpha == 0.0{
                
        UIView.animate(withDuration: 0.4, delay: 4.0, options: .curveEaseOut, animations: {
                self.dialogcloud.alpha = 1
                    
        })
        }else{
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                    self.dialogcloud.alpha = 0.0
                })
            }
        }
    func appearNext(){
        if line >= 6{
                   self.nextgo.alpha = 0.0
        }
        else if nextgo.alpha == 0.0{
                
            UIView.animate(withDuration: 0.1, delay: 10.1, options: .curveEaseOut, animations: {
                    self.nextgo.alpha = 1
            })
        }
    }
    func sound(){
          let pathsound = Bundle.main.path(forResource: "m", ofType: "wav")!
          let url = URL(fileURLWithPath: pathsound)
              
          do{
              audioPlayer = try AVAudioPlayer(contentsOf: url)
              audioPlayer?.play()
          }catch{
              print("Audio error")
          }
      }
    func animateText(words: String){
        for i in words{
           
            AudioServicesPlaySystemSound(1306)
           
            dialog.text! += "\(i)"
            RunLoop.current.run(until: Date() + 0.18)
            
        }
    }

    override func viewDidLoad() {
        
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
        let eye1 = circleView(frame: CGRect(x: 110, y: 360, width: 100, height: 100 ) )
        eye1.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(eye1)
            
        let eye2 = circleView(frame: CGRect(x: 240, y: 360, width: 100, height: 100 ) )
        eye2.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(eye2)
            
        //Eye bling
        let bling1 = cView(frame: CGRect(x: 90, y: 350, width: 100, height: 100 ) )
        bling1.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(bling1)
            
        let bling2 = cView(frame: CGRect(x: 220, y: 350, width: 100, height: 100 ) )
        bling2.backgroundColor = UIColor(white: 1, alpha: 0.0)
        view.addSubview(bling2)
            
        //Antena
        let antena = UIView(frame: CGRect(x: 170, y: 220, width: 3, height: 70 ) )
        antena.backgroundColor =  UIColor.init(red: 99/255, green: 73/255, blue: 71/255, alpha:1.0)
        view.addSubview(antena)
        
        blinkeye()
        dialogcloud.alpha = 0.0
        yellowbox.alpha = 0.0
        redbox.alpha = 0.0
        pinkbox.alpha = 0.0
        greenbox.alpha = 0.0
        nextgo.alpha = 0.0
        level1.alpha = 0.0
        field.alpha = 0.0
        counter.alpha = 0.0
        lastcloud.alpha = 0.0
        storeb.alpha = 0.0
        runn.alpha = 0.0
        insidebox.alpha = 1.0
        finsh.alpha = 0.0
        skii.alpha  = 0.0
        skip.alpha = 0.0
        
        view.addSubview(dialogcloud)
        view.addSubview(nextgo)
        view.addSubview(dialog)
        view.addSubview(yellowbox)
        view.addSubview(redbox)
        view.addSubview(pinkbox)
        view.addSubview(greenbox)
        view.addSubview(level1)
        view.addSubview(field)
        view.addSubview(lastcloud)
        view.addSubview(storeb)
        view.addSubview(counter)
        view.addSubview(runn)
        view.addSubview(insidebox)
        view.addSubview(finsh)
        view.addSubview(skii)
        view.addSubview(skip)
        view.addSubview(start1)
        
    }
    func blinkeye(){
        //The eyelids blinking ^_^
        let eyeb = UIView(frame: CGRect(x: 50, y: 330, width:90,height:60 ) )
        eyeb.backgroundColor = UIColor.init(red: 206/255, green: 236/255,blue: 242/255, alpha: 1.0)
        view.addSubview(eyeb)
            
        let eyeb2 = UIView(frame: CGRect(x: 100, y: 330, width:90,height:60 ) )
        eyeb2.backgroundColor = UIColor.init(red: 206/255, green:236/255, blue: 242/255, alpha: 1.0)
        view.addSubview(eyeb2)
            
        let startPoint1 = CGPoint(x: 150, y: 333)
        let endpoint1 = CGPoint(x: 150, y: 395)
        let startPoint2 = CGPoint(x: 280, y: 333)
        let endpoint2 = CGPoint(x: 280, y: 395)
            
        let duration: Double = 1.9
        let animate1 = constructAnimation(starting: startPoint1, ending:endpoint1, duration: duration)
        let animate2 = constructAnimation(starting: startPoint2, ending:endpoint2, duration: duration)
        eyeb.layer.add(animate1, forKey: "position")
        eyeb2.layer.add(animate2, forKey: "position")
    }
    
    //This is the function that lets the eyelids of Mr.Robot Blink
    func constructAnimation(starting: CGPoint, ending: CGPoint, duration:Double) -> CABasicAnimation{
        let postion = CABasicAnimation(keyPath: "position")
        postion.fromValue = NSValue(cgPoint: starting)
        postion.toValue = NSValue(cgPoint: ending)
        postion.duration = duration
        postion.autoreverses = true
        postion.repeatCount = Float.infinity
        postion.speed = 2.0
        return postion
    }
}

