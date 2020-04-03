//  Created by Nina on 07/07/1441 AH.
//  Copyright © 1441 Nina. All rights reserved.
//  Hand made with love and passion
//------------------------Refractor Status : Completed-----------------------------------------------
//Importing essintial dependencies and frameworks here
import UIKit // For UI
import AVFoundation // To draw Circles
import CocoaMQTT // To connect to the car wirelessly

//----------------The circles-------------------------
class CircleView:UIView{
    
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
class CView:UIView{
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

class Level0: UIViewController {
// an instance of the CocoaMQTT class with all the essintial parameters to establish a successful connection.
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.20.10.12", port: 1883)
    
//---------------All the Buttons initialized here----------------------------------------------
    @IBOutlet weak var cloudBubble: UIImageView!//The cloud that we type on
    
    @IBOutlet weak var runthecode: UIButton!// the execution button to print on car
    
    @IBOutlet weak var printb: UILabel!//just the print function
    
    @IBOutlet weak var printField: UITextField!//the field the user will type in
    
    @IBOutlet weak var trying: UIButton!// lets try and execute
    
    @IBOutlet weak var talking: UILabel!// the moving words
    
    @IBOutlet weak var finishh: UIButton!// The button that returns user to the learn page
    
    @IBOutlet weak var happyCloud: UIImageView!// the happy cloud after finishing
    
    @IBOutlet weak var youDidIt: UILabel!//the happy words!
    
    @IBOutlet weak var b: UILabel!//just the print function
    
    @IBOutlet weak var startButton: UIButton!// the start button
    
    var audioPlayer : AVAudioPlayer? // allows audio to be played
    
    @IBOutlet weak var notdidit: UILabel!// error message when user does not go as expected
    
    @IBOutlet weak var gonext: UIButton!// the next button for dialog
    
    //Skip button they come in pair one is the SKIP lable and the ski is a button
    @IBOutlet weak var ski: UIButton!
    @IBOutlet weak var skip: UILabel!
    
    //------------- The helping variables for the movie scene-----------
    var line = 0 // Decides which dialog is played, Sequencial hence, starts from zero
    var storyLine: [String] = ["Hello World \nMy Name is Mr. Robot!"     ,
                               "Let us talk about Languages"             ,
                               "we don't know human language"            ,
                               "we know machine language"                ,
                               "I speak python!\nusing word \"print()\".",
                               "you can learn to speak python too."      ,
                               "Type a word in print\n to see it in your car\n try it!!"]
    
//------------------------------All the function used in level 0-----------------------
//Takes the user to the learning page
    @IBAction func finished(_ sender: UIButton) {
        levell0 = true//To open the next level
        LockimagArr[1] = "" // removing the lock from level 1 which is the next level
    }
//The skip button to start learning
    @IBAction func Skip(_ sender: UIButton) {
        //Intializing the value in order to skip and start learning
        ski.alpha = 0.0// hide the skip buttom
        skip.alpha = 0.0// hide the skip lable
        line = 6;// last sentence is learn
        talking.text = ""// clear the talking
        self.gonext.alpha = 0.0//hide the next button
        animateText(words: storyLine[line])
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseOut, animations: {
            self.trying.alpha = 1.0
            self.ski.alpha = 0.0
            self.trying.alpha = 0.0
            })
        self.trying.alpha = 1.0 // keep the try button appearent
    }
//pressing try button
    @IBAction func letsTry(_ sender: Any) {
        talking.text = ""
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseOut, animations: {
            self.trying.alpha = 0.0
            self.cloudBubble.alpha = 0.0
        })
        UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveEaseOut, animations: {
            self.printField.alpha = 1.0
            self.printb.alpha = 1.0
            self.b.alpha = 1.0
            self.runthecode.alpha = 1.0
        })
    }
//Running the code after finishing to try
    @IBAction func runCode(_ sender: UIButton) {
        //mqttClient.connect()
        self.animateButton(sender)
        print(String(self.printField.text!))
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
            self.happyCloud.alpha = 1.0
            //Changed here
            if self.printField.text != ""{
                print("inside")
                self.notdidit.alpha = 0
                self.youDidIt.alpha = 1.0
                self.finishh.alpha = 1.0
                self.finishh.alpha = 1.0
                levell0 = true
            }
            else{
                UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
                    self.notdidit.alpha = 1.0
                    self.youDidIt.alpha = 0.0
                })
            }
        })
        // publish the word that the user entered such that the car will display it on the screen
        mqttClient.publish("lvl/0", withString: String(printField.text!))
    }
    
//this will appear 3 times for the scenario hiding the button when the cloud is typing something
    @IBAction func gotoNext(_ sender: UIButton) {
        UIView.animate(withDuration: 0.8, delay: 0.3, options: .curveEaseOut, animations: {
                self.gonext.alpha = 0.0// hide the button
            })
        
        self.animateButton(sender)//animate button
        talking.text = "" // clear the feild of words
        talking.font = talking.font.withSize(18)
        RunLoop.current.run(until: Date() + 0.5)// pause the code here
        
        appearNext()// show the button again
        animateText(words: storyLine[line])// anime the current sentence
        self.line = self.line + 1//probe the line
        
        //if this is the end of the dialog
        if line > 6{
            self.gonext.alpha = 0.0
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.trying.alpha = 1.0
            })
        }
        
    }
    
//The start button at the beginning of the intro
    @IBAction func Button(_ sender: UIButton) {
        if startButton.alpha == 1.0{// if it is initialy on diplayed on screen
            sound()// play sound when pressed
            self.animateButton(sender)// animate the button
            fade()// fade the START button
            appearcloud()
            
            RunLoop.current.run(until: Date() + 8.0)// pause the code her for 8 ms
            
            appearNext()
            talking.font = talking.font.withSize(18)
            animateText(words: storyLine[line])
            self.line = self.line + 1
        }
        ski.alpha = 1.0// apear Skip button
        skip.alpha = 1.0// appear skip lable
    }
    
//-----------------------------helping functions to read code easier ------------------------
    //Fades the start button
    func fade(){
        UIView.animate(withDuration: 1.5, delay: 0.8, options: .curveEaseOut, animations: {
                self.startButton.alpha = 0.0
        })
    }
    
//will let the next button appear
    func appearNext(){
        if line >= 6{ // if it is the end of the story line
            self.gonext.alpha = 0.0// hide
        }
        else if gonext.alpha == 0.0{
            UIView.animate(withDuration: 0.1, delay: 6.0, options: .curveEaseOut, animations: {
                self.gonext.alpha = 1// appear
            })
        }
    }
    
//Let the beginning cloud appear an stay like that
    func appearcloud(){
        if cloudBubble.alpha == 0.0{// if it is initially hidden
            UIView.animate(withDuration: 0.4, delay: 8.0, options: .curveEaseOut, animations: {
                 self.cloudBubble.alpha = 1 // show it
            })
         }else{
             UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                     self.cloudBubble.alpha = 0.0 // hide it
                 })
             }
        }
    
//The sound for the intro of the start button
    func sound(){
        let pathsound = Bundle.main.path(forResource: "B", ofType: "wav")!// The sound file
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
            AudioServicesPlaySystemSound(1306)
            talking.text! += "\(i)"
            RunLoop.current.run(until: Date() + 0.18)// the speed of typing the letters
        }
    }
    
//------------------The main---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        mqttClient.connect()// establishing a connection
        backgroundDisplay()//Display the moving background
        mrRobot()// Draw Mr.Robot
        blinkeye() //Let Mr.Robot blink!!! ^_~

//---------------hide all the icons first, then let the appear as wanted----------------------------------
        //Buttons respinsible for diplaying text and moving along the story line
        cloudBubble.alpha = 0.0
        gonext.alpha = 0.0
        trying.alpha = 0.0
        
        //Buttons responsible for the print and the print field with its run  button
        printField.alpha = 0.0
        printb.alpha = 0.0
        b.alpha = 0.0
        runthecode.alpha = 0.0
        
        //Buttons and cloud dealing with success and error messages
        happyCloud.alpha = 0.0
        youDidIt.alpha = 0.0
        notdidit.alpha = 0.0
        
        //Buttons dealing with skiping to the last of learning session
        ski.alpha = 0.0
        skip.alpha = 0.0
        
        finishh.alpha = 0.0//Going to the learn page

//-----------View all the Scene however some are transparents so that they don't get in the way--------------
        view.addSubview(cloudBubble)
        view.addSubview(gonext)
        view.addSubview(talking)
        view.addSubview(trying)
        view.addSubview(printField)
        view.addSubview(printb)
        view.addSubview(b)
        view.addSubview(runthecode)
        view.addSubview(happyCloud)
        view.addSubview(youDidIt)
        view.addSubview(notdidit)
        view.addSubview(finishh)
        view.addSubview(startButton)
        view.addSubview(ski)
        view.addSubview(skip)
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
