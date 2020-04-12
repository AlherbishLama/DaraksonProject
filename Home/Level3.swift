// Level3
//  Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Completed-----------------------------------------------
//Importing essintial dependencies and frameworks here
import UIKit // For UI
import AVFoundation // To draw Circles
import CocoaMQTT // To connect to the car wirelessly
import Firebase // for linking the project with firebase.

//----------------The circles-------------------------
class CcircleView:UIView{
    
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
class CcView:UIView{
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


class Level3: UIViewController {
    
//---------------All the Buttons initialized here----------------------------------------------
    
   
    
    @IBOutlet weak var Start: UIButton!
    
    @IBOutlet weak var BigCloud: UIImageView!
    
    @IBOutlet weak var Next: UIButton!
    
    @IBOutlet weak var smallcloud: UIImageView!
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var Skipp: UIButton!
    
    @IBOutlet weak var Skippp: UILabel!

    @IBOutlet weak var Next22: UIButton!
    //------------------------------All the function used in level 3--------
    
//The button takes user to Last page
    @IBAction func Next222(_ sender: UIButton) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: "Last") as! Last
        self.navigationController?.pushViewController(storyboard, animated:true)
        
    }
    
    var audioPlayer : AVAudioPlayer?
    
    var line = 0 // Decides which dialog is played, Sequencial hence, starts from zero
    var hidden = true
    var storyLine: [String] = ["if you need the story line you will understand better else, when                         you skip? you still can learn!",
                               "the previous example give you 2 choices"            ,
                               "Did you noteced the 'if-else?'"                ,
                               "if-else is new concept make you decide between a lot of flows... 2flows,3flows or more!"]
    
   
//The skip button to start learning
    @IBAction func SKIP(_ sender: UIButton) {
        if (hidden){//if pressed while hidden
                   print("inside")
                   return
               }

           }
    
//The button responsible for the next dialog of the learning scene
    @IBAction func Next(_ sender: UIButton) {
        if(self.hidden){
                   return
               }
               
               UIView.animate(withDuration: 0.8, delay: 0.3, options: .curveEaseOut, animations: {
                       self.hidden = true
                       self.Next.alpha = 0.0// hide the button
                self.Skipp.alpha = 0.0// hide the skip buttom
                self.Skippp.alpha = 0.0// hide the skip lable
                   })
               self.animateButton(sender)//animate button
               Label.text = "" // clear the feild of words
               Label.font = Label.font.withSize(18)
               RunLoop.current.run(until: Date() + 0.5)// pause the code here
               appearNext()// show the button again
               
               animateText(words: storyLine[line]) // anime the current sentence
               self.line = self.line + 1 //probe the line
               //if this is the end of the dialog
               if line >= 4{
                   self.Next.alpha = 0.0
                   // Label.alpha = 0.0
                self.Next22.alpha = 1.0
             //  let storyboard = self.storyboard?.instantiateViewController(identifier: "Last") as! Last
              //      self.navigationController?.pushViewController(storyboard, animated:true)
             //   self.hidden = false
        }
        self.hidden = false
    }
    
//The start button at the beginning of the intro
    @IBAction func Start(_ sender: UIButton) {
        if Start.alpha == 1.0{// if it is initialy on diplayed on screen
            sound()// play sound when pressed
            self.animateButton(sender)// animate the button
            fade()// fade the START button
            appearcloud()
            
            RunLoop.current.run(until: Date() + 5.0)// pause the code her for 8 ms
            
            appearNext()
            Label.font = Label.font.withSize(18)
            animateText(words: storyLine[line])
            self.line = self.line + 1
        }
        Skipp.alpha = 1.0
        Skippp.alpha = 1.0
        self.hidden = false
    }
    
//-----------------------------helping functions to read code easier ------------------------
    //Fades the start button
        func fade(){
            UIView.animate(withDuration: 1.5, delay: 0.8, options: .curveEaseOut, animations: {
                    self.Start.alpha = 0.0
            })
        }
        
        //will let the next button appear
        func appearNext(){
            
            if line == 4{ // if it is the end of the story line
                self.Next.alpha = 0.0// hide
            }
            else if Next.alpha == 0.0{
                UIView.animate(withDuration: 0.1, delay: 4.0, options: .curveEaseOut, animations: {
                    
                    self.Next.alpha = 1 // appear
                    self.Skipp.alpha = 1.0
                    self.Skippp.alpha = 1.0
                })
                
            }
        }

//Let the beginning cloud appear an stay like that
        func appearcloud(){
            if BigCloud.alpha == 0.0{// if it is initially hidden
                UIView.animate(withDuration: 0.4, delay: 5.0, options: .curveEaseOut, animations: {
                     self.BigCloud.alpha = 1 // show it
                })
             }else{
                 UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                         self.BigCloud.alpha = 0.0 // hide it
                     })
                 }
            }
        
//The sound for the intro of the start button
        func sound(){
            let pathsound = Bundle.main.path(forResource: "m", ofType: "wav")!// The sound file
            let url = URL(fileURLWithPath: pathsound)
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }catch{
                print("Audio error")
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
//to animate the typing effect of the words
    func animateText(words: String){
        //For each letter in word
        for i in words{
            //AudioServicesPlaySystemSound(1306)
            Label.text! += "\(i)"
            RunLoop.current.run(until: Date() + 0.18)// the speed of typing the letters
        }
    }

        
//------------------The main---------------------------------------
override func viewDidLoad() {
        super.viewDidLoad()
        backgroundDisplay()//Display the moving background
        mrRobot()// Draw Mr.Robot
        blinkeye() //Let Mr.Robot blink!!! ^_~

//---------------hide all the icons first, then let the appear as wanted----------------------------------
        
    //Buttons respinsible for diplaying text and moving along the story line
    BigCloud.alpha = 0.0
    Next.alpha = 0.0
    Next22.alpha = 0.0
                
    //Buttons dealing with skiping to the last of learning session
    Skipp.alpha = 0.0
    Skippp.alpha = 0.0
                
               

//-----------View all the Scene however some are transparents so that they don't get in the way--------------
    view.addSubview(BigCloud)
    view.addSubview(Next)
    view.addSubview(Next22)
    view.addSubview(Label)
    view.addSubview(Skipp)
    view.addSubview(Skippp)
    view.addSubview(Start)
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
