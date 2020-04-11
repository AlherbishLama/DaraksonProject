// Level 1 
//  Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Completed-----------------------------------------------
//Importing essintial dependencies and frameworks here
import UIKit // For UI
import AVFoundation // To draw Circles
import CocoaMQTT // To connect to the car wirelessly
import Firebase // for linking the project with firebase.
//-------------------Circle--------------------------------------------------------------------------
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
// an instance of the CocoaMQTT class with all the essintial parameters to establish a successful connection.
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "172.20.10.12", port: 1883)
 
//---------------All the Buttons initialized here----------------------------------------------
    //All boxes in this level
    @IBOutlet weak var pinkbox: UIImageView!//Pink box
    @IBOutlet weak var redbox: UIImageView! //The small red box
    @IBOutlet weak var yellowbox: UIImageView!//The big yellow box
    @IBOutlet weak var greenbox: UIImageView!// the green box
    
    @IBOutlet weak var lastcloud: UIImageView!//the cloud that displays number of words stored
    
    @IBOutlet weak var start1: UIButton!//The button that starts the game
    
    @IBOutlet weak var nextgo: UIButton!// the next button for dialog
    
    @IBOutlet weak var dialog: UILabel!// the moving words
    
    @IBOutlet weak var dialogcloud: UIImageView!//The cloud that we type on
    
    @IBOutlet weak var finsh: UIButton!//Returns user to learn page
    
    var audioPlayer : AVAudioPlayer?// allows audio to be played
    
    //The storage of words and emptying the storage
    @IBOutlet weak var insidebox: UILabel!//Will display everything stored in words array
    @IBOutlet weak var counter: UILabel!//counts the nymber of stored words
    var words : [String] = []// All the words that the user stores will be appended here maximim storage 3
    @IBOutlet weak var runn: UIButton!//the stored words will be removed from the yellow box when run
    @IBOutlet weak var field: UITextField!// the feild for storing words
    @IBOutlet weak var level1: UILabel!// lable stating level 1 variable is the yellow box
    @IBOutlet weak var storeb: UIButton!//The store button
    
    //The Skip buttons
    @IBOutlet weak var skii: UIButton!// the skip button
    @IBOutlet weak var skip: UILabel!// The skip lable

    //------------- The helping variables for the movie scene-----------
    var storyLine: [String] = ["Welcome Back, nice to see you!\nLets learn\nabout \"variables\"",
                               "hmm how do I\nremember your name everytime\nyou log-in?"        ,
                               "I save all your data \ninside boxes named variables"            ,
                               "I have a lot of boxes\n different colors and sizes"             ,
                               "each box belongs to a special\n\"variable\" ^_^"                ,
                               "this variable name is Level 1\n you can store inside it"        ,
                               "Try type a word and I will\nstore it inside level 1 variable"   ]
    var line = 0
    var count = 0
    var hidden = true
 //------------------------------All the function used in level 0--------
    //Takes the user to the learning page
    @IBAction func fefo(_ sender: UIButton) {
          levell1 = true//To open the next level
        if statics.childLevel == "2" || statics.childLevel == "3"{
            return ;
        }else{
          updateChildLevel()
        LockimagArr[2] = "" // removing the lock from level 2 which is the next level
        }}
    func updateChildLevel(){
        let current = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(current!).updateChildValues(["Level":"2"])
    }
//The skip button to start learning
    @IBAction func skipp(_ sender: UIButton) {
        if (hidden){//if pressed while hidden
            print("inside")
            return
        }
        //hide everything
        //self.hidden = true
        nextgo.alpha = 0.0
        skii.alpha = 0.0
        skip.alpha = 0.0
        
        line = 6//Go to the last dialog
        dialog.text  = ""// empty the dialog
        animateText(words: storyLine[line])//start writng the last dialog
        
        //let everything appear that is resposible to start the learning process
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.yellowbox.alpha = 1.0
            self.level1.alpha = 1.0
            self.greenbox.alpha = 0.0
            self.pinkbox.alpha = 0.0
            self.redbox.alpha = 0.0
        })
         
        RunLoop.current.run(until: Date() + 0.5)// pause the code here
        
        //Appear the store, and the cloud as well as the fiels.
        self.dialog.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.dialogcloud.alpha = 0.0
            self.field.alpha = 1.0
            self.counter.alpha = 1.0
            self.lastcloud.alpha = 1.0
            self.storeb.alpha = 1.0
                
        })
    }
//Running the code it empties everything stored in the yellow box
    @IBAction func empty(_ sender: Any) {
        counter.text = "stored 0"//set to zero
        count = 0
        words.removeAll()
        
        //Then hide button and clear everything
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
//The method resposible for dipslaying how much is stored and what is stored and where is it stored.
    @IBAction func storecounter(_ sender: UIButton) {
        if (field.text! != ""){
            if (count < 3){//If it is less than three
                count = count + 1// increment counter
                words.append(field.text!)//add that word to the array
                insidebox.text = insidebox.text! + words[count-1] + "\n"//display inside the yellow bos
                counter.text = "stored \(count)"// display how much is counted
                field.text = ""//empty the typing field
            }
            
            if (count >= 3){ // if greater or equal to 3
                counter.text = "level 1 is full click\n run to empty "// display a message the box is full
                
                //display all the buttons responsible for emptying the box
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
//The button responsible for the next dialog of the learning scene
    @IBAction func nextt(_ sender: UIButton) {
        
        if(self.hidden){
            return
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.3, options: .curveEaseOut, animations: {
            self.hidden = true
            self.nextgo.alpha = 0.0// hide the next button
            self.skii.alpha = 0.0// hide Skip button
            self.skip.alpha = 0.0// hide skip lable
        })
        self.animateButton(sender)// animate the button
        dialog.text = ""//empty the dialog
        dialog.font = dialog.font.withSize(18)//set dialog size
        
        RunLoop.current.run(until: Date() + 0.5)// pause the code
        
        appearNext()// display the next button
        animateText(words: storyLine[line])// start wrttinng the dialog
        //self.hidden = false
        self.line = self.line + 1// increment line scene
        if line > 6{ // if end of the dialog
            self.nextgo.alpha = 0.0//hide next
            
            RunLoop.current.run(until: Date() + 0.5)// pause the code
            
            self.dialog.alpha = 0.0 // hide the dialog
            
            //Display all buttons responsable for starting the learning process
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.dialogcloud.alpha = 0.0
                self.field.alpha = 1.0
                self.counter.alpha = 1.0
                self.lastcloud.alpha = 1.0
                self.storeb.alpha = 1.0
            })
        }
        
        if line == 3 {// if exactly 3 just display the yellow box
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.yellowbox.alpha = 1.0
            })
        }
        // if it equals exactly  or 5display all the boxes except for the yellow box
        else if line == 4 || line == 5{
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.yellowbox.alpha = 0.0
                self.greenbox.alpha = 1.0
                self.pinkbox.alpha = 1.0
                self.redbox.alpha = 1.0
            })
        }
        // if the last dialog the display everything that will be necessary for the learning progress such as yellow box and its lable
        else if line == 6 {
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.yellowbox.alpha = 1.0
                self.level1.alpha = 1.0
                self.greenbox.alpha = 0.0
                self.pinkbox.alpha = 0.0
                self.redbox.alpha = 0.0
            })
        }
        self.hidden = false
    }    
//The start button at the beginning of the intro
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
            }
        skii.alpha = 1.0// apear Skip button
        skip.alpha = 1.0// appear skip lable
        self.hidden = false
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
    
//Fades the start button
    func fade(){
        UIView.animate(withDuration: 1.5, delay: 0.7, options: .curveEaseOut, animations: {
            self.start1.alpha = 0.0
        })
    }
    
//Let the beginning cloud appear an stay like that
    func appearcloud(){
        if dialogcloud.alpha == 0.0{// if it is initially hidden
            UIView.animate(withDuration: 0.4, delay: 4.0, options: .curveEaseOut, animations: {
                self.dialogcloud.alpha = 1// show it
            })
        }else{
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                self.dialogcloud.alpha = 0.0// hide it
            })
        }
     }

//will let the next button appear
    func appearNext(){
        if line >= 6{
            self.nextgo.alpha = 0.0// hide
        }
        else if nextgo.alpha == 0.0{
            UIView.animate(withDuration: 0.1, delay: 10.1, options: .curveEaseOut, animations: {
                self.nextgo.alpha = 1.0// appear
                self.skii.alpha = 1.0// appear Skip button
                self.skip.alpha = 1.0// appear skip lable
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
    
//to animate the typing effect of the words
    func animateText(words: String){
        for i in words{
            AudioServicesPlaySystemSound(1306)
            dialog.text! += "\(i)"
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
        
//---------------hide all the icons first, then let the appear as wanted---------------------------
        //Buttons respinsible for diplaying text and moving along the story line
        dialogcloud.alpha = 0.0
        nextgo.alpha = 0.0
        
        //All the boxes
        redbox.alpha = 0.0
        pinkbox.alpha = 0.0
        greenbox.alpha = 0.0
        yellowbox.alpha = 0.0// our main bos
        level1.alpha = 0.0 // the lable of the level 1 box
        
        //Responsible for the learning like sroeing and running the yellow box
        insidebox.alpha = 1.0// view what is inside the box
        counter.alpha = 0.0// count number of stored variables
        storeb.alpha = 0.0// stores variables inside the box
        runn.alpha = 0.0
        field.alpha = 0.0
        lastcloud.alpha = 0.0
        
        //button resposible for the skipping of dialog
        skii.alpha  = 0.0//skip button
        skip.alpha = 0.0// Skip lable
        
        finsh.alpha = 0.0// return button to the learn page
        
//-----------View all the Scene however some are transparents so that they don't get in the way------------
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

