// Store
//  Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Completed-----------------------------------------------
//Importing essintial dependencies and frameworks here
import UIKit // For UI
import AVFoundation // To draw Circles
import CocoaMQTT // To connect to the car wirelessly
import Firebase // for linking the project with firebase.

//----------------The circles-------------------------
class CcccircleView:UIView{
    
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
class CcccView:UIView{
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


class tostore: UIViewController {
// an instance of the CocoaMQTT class with all the essintial parameters to establish a successful connection.
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.20.10.12", port: 1883)

//---------------All the Buttons initialized here----------------------------------------------

    @IBOutlet weak var Bigcloud3: UIImageView!//The cloud that we type on
    
    @IBOutlet weak var huppy2: UIImageView!// the happy cloud after finishing
    
    @IBOutlet weak var Label2: UILabel!//
    
    @IBOutlet weak var yellowbox: UIImageView!//The big yellow box
    
    
    @IBOutlet weak var stored0: UILabel!
    //Will display everything stored in words array
    
    @IBOutlet weak var storebutton: UIButton!//The store button
    
    @IBOutlet weak var runbutton: UIButton!//The stored words will be removed from the yellow box when run
    
    @IBOutlet weak var abovelabel: UILabel!//The label that apears in box
    
    @IBOutlet weak var textfiled2: UITextField!// the feild for storing words
    
    @IBOutlet weak var Back2: UIButton!//Takes the user to the Last page

    
    var words : [String] = []// All the words that the user stores will be appended here maximim storage 3
    var count = 0//counts the nymber of stored words
    
//------------------------------All the function used in Store --------
    
//Running the code it empties everything stored in the yellow box
    @IBAction func rrun(_ sender: UIButton) {
        stored0.text = "stored 0"//set to zero
        count = 0
        words.removeAll()
        
        //Then hide button and clear everything
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.runbutton.alpha = 0.0
            self.textfiled2.alpha = 1.0
            self.stored0.alpha = 1.0
            self.huppy2.alpha = 1.0
            self.storebutton.alpha = 1.0
            self.abovelabel.text = ""
            self.Back2.alpha = 1.0
        })
    }
    

//The method resposible for dipslaying how much is stored and what is stored and where is it stored.
    
    
    
    @IBAction func Store(_ sender: UILabel) {
        if (textfiled2.text! != ""){
            if (count < 3){//If it is less than three
                count = count + 1// increment counter
                words.append(textfiled2.text!)//add that word to the array
                abovelabel.text = abovelabel.text! + words[count-1] + "\n"//display inside the yellow bos
                stored0.text = "stored \(count)"// display how much is counted
                textfiled2.text = ""//empty the typing field
            }
            
            if (count >= 3){ // if greater or equal to 3
                stored0.text = "The box is full click\n run to empty "// display a message the box is full
                
                //display all the buttons responsible for emptying the box
                UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                    self.runbutton.alpha = 1.0
                    self.textfiled2.alpha = 0.0
                    self.stored0.alpha = 1.0
                    self.huppy2.alpha = 1.0
                    self.storebutton.alpha = 0.0
                    self.Back2.alpha = 1.0
                })
            }
        }
        
    }
    
//-----------------------------helping functions to read code easier ------------------------

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
                
//---------------hide all the icons first, then let the appear as wanted---------------------------

        //Buttons respinsible for diplaying text
        yellowbox.alpha = 1.0// our main bos
        Label2.alpha = 1.0 // the lable of the level 1 box
        
        //Responsible for the learning like sroeing and running the yellow box
        abovelabel.alpha = 1.0// view what is inside the box
        stored0.alpha = 1.0// count number of stored variables
        storebutton.alpha = 1.0// stores variables inside the box
        runbutton.alpha = 0.0// empty the box from stored word
        textfiled2.alpha = 1.0// the filed that promot words from user
        huppy2.alpha = 0.0// the cloud that say huppy words
        
        
        Back2.alpha=0.0
        
        
        view.addSubview(yellowbox)
        view.addSubview(Label2)
        view.addSubview(textfiled2)
        view.addSubview(huppy2)
        view.addSubview(storebutton)
        view.addSubview(stored0)
        view.addSubview(runbutton)
        view.addSubview(abovelabel)
        view.addSubview(Back2)
        
    }
    
//-----------------------Functions responsible for displaying the background and drawing Mr Robot------------

//The background function for the level
        func backgroundDisplay(){
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
        }
//Mr.Robots Eye blinking, P.s We all blink if you don't the please get that checked
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
