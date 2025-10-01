//
//  SettingsViewController.swift
//  RollingLabyrinth
//
// Lukas Vatistas (lvatista@iu.edu)
// Connor Hands(cahands@iu.edu)
// Project Name: MarbleMazeMobile
// A04 submission date: 4/12/24
// A05 submission date: 4/19/24

import UIKit

class SettingsViewController: UIViewController {
    
    //appDelegate and model
    var appDelegate: AppDelegate?
    var myModel: RollingLabyrinthModel?
    
    //Difficulty Buttons
    @IBAction func EasyButton(_ sender: Any) {
        self.myModel?.difficulty = 1
        setDifficultyIndicator()
    }
    @IBAction func MediumButton(_ sender: Any) {
        self.myModel?.difficulty = 2
        setDifficultyIndicator()
    }
    @IBAction func HardButton(_ sender: Any) {
        self.myModel?.difficulty = 3
        setDifficultyIndicator()
    }
    
    //Ball Color Buttons
    @IBAction func RedBallButton(_ sender: Any) {
        self.myModel?.ballColor = "red"
        setBallColorIndicator()
    }
    @IBAction func GreenBallButton(_ sender: Any) {
        self.myModel?.ballColor = "green"
        setBallColorIndicator()
    }
    @IBAction func BlueBallButton(_ sender: Any) {
        self.myModel?.ballColor = "blue"
        setBallColorIndicator()
    }
    @IBAction func BlackBallButton(_ sender: Any) {
        self.myModel?.ballColor = "black"
        setBallColorIndicator()
    }
    
    //Background Buttons
    @IBAction func RedBGButton(_ sender: Any) {
        self.myModel?.backgroundColor = UIColor.red
        setBackgroundColorIndicator()
    }
    @IBAction func GreenBGButton(_ sender: Any) {
        self.myModel?.backgroundColor = UIColor.green
        setBackgroundColorIndicator()
    }
    @IBAction func BlueBGButton(_ sender: Any) {
        self.myModel?.backgroundColor = UIColor.blue
        setBackgroundColorIndicator()
    }
    @IBAction func GrayBGButton(_ sender: Any) {
        self.myModel?.backgroundColor = UIColor.systemGray2
        setBackgroundColorIndicator()
    }
    
    //Select Indicators labels
    ///Difficulty
    @IBOutlet weak var easySelectIndicator: UILabel!
    @IBOutlet weak var mediumSelectIndicator: UILabel!
    @IBOutlet weak var hardSelectIndicator: UILabel!
    ///Ball Color
    @IBOutlet weak var redBallIndicator: UILabel!
    @IBOutlet weak var greenBallIndicator: UILabel!
    @IBOutlet weak var blueBallIndicator: UILabel!
    @IBOutlet weak var blackBallIndicator: UILabel!
    ///Background Color
    @IBOutlet weak var redBackgroundIndicator: UILabel!
    @IBOutlet weak var greenBackgroundIndicator: UILabel!
    @IBOutlet weak var blueBackgroundIndicator: UILabel!
    @IBOutlet weak var grayBackgroundIndicator: UILabel!
    
    //Rest indicator functions
    func setDifficultyIndicator(){
        //Reset all indicators
        easySelectIndicator.text = ""
        mediumSelectIndicator.text = ""
        hardSelectIndicator.text = ""
        
        //Activate correct indicator
        if (self.myModel?.difficulty == 1){easySelectIndicator.text = "X"}
        else if(self.myModel?.difficulty == 2){mediumSelectIndicator.text = "X"}
        else{hardSelectIndicator.text = "X"}
    }
    func setBallColorIndicator(){
        //Reset all indicators
        redBallIndicator.text = ""
        greenBallIndicator.text = ""
        blueBallIndicator.text = ""
        blackBallIndicator.text = ""
        
        //Activate correct indicator
        if (self.myModel?.ballColor == "red"){redBallIndicator.text = "X"}
        else if (self.myModel?.ballColor == "green"){greenBallIndicator.text = "X"}
        else if (self.myModel?.ballColor == "blue"){blueBallIndicator.text = "X"}
        else {blackBallIndicator.text = "X"}
    }
    func setBackgroundColorIndicator(){
        //Reset all indicators
        redBackgroundIndicator.text = ""
        greenBackgroundIndicator.text = ""
        blueBackgroundIndicator.text = ""
        grayBackgroundIndicator.text = ""
        
        //Activate correct indicator
        if (self.myModel?.backgroundColor == UIColor.red){redBackgroundIndicator.text = "X"}
        else if (self.myModel?.backgroundColor == UIColor.green){greenBackgroundIndicator.text = "X"}
        else if (self.myModel?.backgroundColor == UIColor.blue){blueBackgroundIndicator.text = "X"}
        else {grayBackgroundIndicator.text = "X"}
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Obtain a reference to the app delegate and model
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        
        //Set all indicators to correct Setting
        setDifficultyIndicator()
        setBallColorIndicator()
        setBackgroundColorIndicator()

    }


}
