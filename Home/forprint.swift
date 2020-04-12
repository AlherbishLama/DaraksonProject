// forprint
//  Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Completed-----------------------------------------------
//Importing essintial dependencies and frameworks here
import UIKit // For UI
import AVFoundation // To draw Circles
import CocoaMQTT // To connect to the car wirelessly
import Firebase // for linking the project with firebase.

//----------------The circles-------------------------
class CccircleView:UIView{
    
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
class CccView:UIView{
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



class forprint: UIViewController {
// an instance of the CocoaMQTT class with all the essintial parameters to establish a successful connection.
    
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.20.10.12", port: 1883)
    
//---------------All the Buttons initialized here----------------------------------------------
    
    @IBOutlet weak var Bigcloud2: UIImageView!
    
    @IBOutlet weak var textfiled: UITextField!
    
    @IBOutlet weak var print: UILabel!
    
    @IBOutlet weak var otherside: UILabel!
    
    @IBOutlet weak var rrun: UIButton!
    
    @IBOutlet weak var huppy: UIImageView!
    
    @IBOutlet weak var udidit: UILabel!
    
    @IBOutlet weak var udiditnot: UILabel!
    
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Back: UIButton!
    
//------------------------------All the function used in Store --------
        
//Running the code it empties everything stored in the yellow box
    @IBAction func torun(_ sender: UIButton) {
        self.animateButton(sender)
        Swift.print(String(self.textfiled.text!))
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
            self.huppy.alpha = 1.0
            //Changed here
            if self.textfiled.text != ""{
                Swift.print("inside")
                self.udiditnot.alpha = 0
                self.udidit.alpha = 1.0
                self.Back.alpha = 1.0
                self.Back.alpha = 1.0
              
            }
            else{
                UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
                    self.udiditnot.alpha = 1.0
                    self.udidit.alpha = 0.0
                })
            }
        })
        // publish the word that the user entered such that the car will display it on the screen
        mqttClient.publish("lvl/0", withString: String(textfiled.text!))
        
    }

//-----------------------------helping functions to read code easier ------------------------
//will let the next button appear
    func appearcloud(){
    if Bigcloud2.alpha == 0.0{// if it is initially hidden
        UIView.animate(withDuration: 0.4, delay: 5.0, options: .curveEaseOut, animations: {
             self.Bigcloud2.alpha = 1 // show it
        })
     }else{
         UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                 self.Bigcloud2.alpha = 0.0 // hide it
             })
         }
    }
//This method animates all the button to give them the spring effect
    func animateButton(_ viewA: UIView){
    UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            viewA.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
        }){(_) in }
    
    UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.5, options: .curveEaseIn, animations: {
            viewA.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }

//------------------The main---------------------------------------

    
override func viewDidLoad() {
        super.viewDidLoad()
    mqttClient.connect()// establishing a connection
    backgroundDisplay()//Display the moving background
    mrRobot()// Draw Mr.Robot
    blinkeye() //Let Mr.Robot blink!!! ^_~
    
//---------------hide all the icons first, then let the appear as wanted----------------------------------
    
    //Buttons respinsible for diplaying text
    Bigcloud2.alpha = 0.0
    
    //Buttons responsible for the print and the print field with its run  button
    textfiled.alpha = 1.0
    print.alpha = 1.0
    otherside.alpha = 1.0
    rrun.alpha = 1.0
    
    //Buttons and cloud dealing with success and error messages
    huppy.alpha = 0.0
    udidit.alpha = 0.0
    udiditnot.alpha = 0.0
    
    Back.alpha = 0.0
    
    view.addSubview(Bigcloud2)
    view.addSubview(textfiled)
    view.addSubview(print)
    view.addSubview(otherside)
    view.addSubview(rrun)
    view.addSubview(huppy)
    view.addSubview(udidit)
    view.addSubview(udiditnot)
    view.addSubview(Back)
    
    }
//-----------------------Functions responsible for displaying the background and drawing Mr Robot------------
//The background function for the level
    func backgroundDisplay(){
            // the background of the view initilizing the size
            let backview = UIView()
            backview.frame.size = CGSize(width: 500, height: 1000)
            backview.center = self.view.center
            self.view.addSubview(backview)
            
            // Animating the background to move the ombre color
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
        }
//Drawing Mr Robot
        func mrRobot(){
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
            let eye1 = CircleView(frame: CGRect(x: 110, y: 360, width: 100, height: 100 ) )
            eye1.backgroundColor = UIColor(white: 1, alpha: 0.0)
            view.addSubview(eye1)
                
            let eye2 = CircleView(frame: CGRect(x: 240, y: 360, width: 100, height: 100 ) )
            eye2.backgroundColor = UIColor(white: 1, alpha: 0.0)
            view.addSubview(eye2)
                
            //Eye bling
            let bling1 = CView(frame: CGRect(x: 90, y: 350, width: 100, height: 100 ) )
            bling1.backgroundColor = UIColor(white: 1, alpha: 0.0)
            view.addSubview(bling1)
                
            let bling2 = CView(frame: CGRect(x: 220, y: 350, width: 100, height: 100 ) )
            bling2.backgroundColor = UIColor(white: 1, alpha: 0.0)
            view.addSubview(bling2)
                
            //Antena
            let antena = UIView(frame: CGRect(x: 170, y: 220, width: 3, height: 70 ) )
            antena.backgroundColor =  UIColor.init(red: 99/255, green: 73/255, blue: 71/255, alpha:1.0)
            view.addSubview(antena)
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
        }


}
