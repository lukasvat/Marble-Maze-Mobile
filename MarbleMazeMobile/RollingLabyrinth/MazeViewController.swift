//
//  MazeViewController.swift

// Lukas Vatistas (lvatista@iu.edu)
// Connor Hands(cahands@iu.edu)
// Project Name: MarbleMazeMobile
// A04 submission date: 4/12/24
// A05 submission date: 4/19/24

import UIKit
import SpriteKit

class MazeViewController: UIViewController {
    
    var appDelegate: AppDelegate?
    var myModel: RollingLabyrinthModel?
    var gameScene: GameScene?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var MazeSKView: SKView!
    
    var timer : Timer = Timer()
    var count : Int = 0
    // myModel.timerCounting
    
    @IBAction func startButton(_ sender: Any){
        timerButtonPressed()
    }
    
    func timerButtonPressed(){
        if let tmpModel = myModel{
            // Stop Timer
            if(tmpModel.timerCounting){
                tmpModel.timerCounting = false
                self.count = 0
                self.timer.invalidate()
                self.timeLabel.text = makeTimeString(minutes: 0, seconds: 0)
                startButton.setTitle("Start Game", for: .normal)
                
            }
            // Start Timer
            else{
                tmpModel.gamesPlayed += 1
                tmpModel.timerCounting = true
                startButton.setTitle("Stop Game", for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func timerCounter() -> Void{
        count = count + 1
        let time = secondsToMinutesSeconds(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        if let tmpModel = myModel{
            tmpModel.savedTimerInt = count
            tmpModel.savedTimerString = timeString
            
        }
        timeLabel.text = timeString
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int,Int){
        return ((seconds % 3600)/60,(seconds%36000)%60)
    }
    
    func makeTimeString(minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d",minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func updateDifficulty(){
        let easyScene = GameScene(fileNamed: "EasyGameScene.sks")
        let mediumScene = GameScene(fileNamed: "MediumGameScene.sks")
        let hardScene = GameScene(fileNamed: "HardGameScene.sks")
        
        if myModel?.difficulty == 1{
            MazeSKView.presentScene(easyScene)
        }
        else if myModel?.difficulty == 2{
            MazeSKView.presentScene(mediumScene)
        }
        else{
            MazeSKView.presentScene(hardScene)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDifficulty()
        // checks if it needs to reset timer after every 0.01 seconds
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if let tmpModel = self.myModel, tmpModel.updateHighScore {
                tmpModel.updateHighScore = false

                // if game is won and time is less than previous hs, update hs
                
                if(tmpModel.difficulty == 1 && tmpModel.easyHSInt > self.count){
                    tmpModel.easyHSInt = self.count
                    tmpModel.easyHS = timeLabel.text!
                }
                else if(tmpModel.difficulty == 2 && tmpModel.mediumHSInt > self.count){
                    tmpModel.mediumHSInt = self.count
                    tmpModel.mediumHS = timeLabel.text!
                }
                else if(tmpModel.difficulty == 3 && tmpModel.hardHSInt > self.count){
                    tmpModel.hardHSInt = self.count
                    tmpModel.hardHS = timeLabel.text!
                }
            }
            if let tmpModel = self.myModel, tmpModel.resetTimer {
                tmpModel.resetTimer = false
                self.timerButtonPressed()
            }
        }
    }
    
    
}

