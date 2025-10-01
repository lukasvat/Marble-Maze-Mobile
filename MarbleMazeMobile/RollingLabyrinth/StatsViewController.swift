//
//  StatsViewController.swift
//  RollingLabyrinth
//
// Lukas Vatistas (lvatista@iu.edu)
// Connor Hands(cahands@iu.edu)
// Project Name: MarbleMazeMobile
// A04 submission date: 4/12/24
// A05 submission date: 4/19/24

import UIKit

class StatsViewController: UIViewController {
    
    //appDelegate and model
    var appDelegate: AppDelegate?
    var myModel: RollingLabyrinthModel?
    
    //Labels
    @IBOutlet weak var GamesPlayedLabel: UILabel!
    @IBOutlet weak var GamesWonLabel: UILabel!
    @IBOutlet weak var EasyHSLabel: UILabel!
    @IBOutlet weak var MediumHSLabel: UILabel!
    @IBOutlet weak var HardHSLabel: UILabel!
    
    func refresh(){
        self.GamesPlayedLabel.text = "\(self.myModel!.gamesPlayed)"
        self.GamesWonLabel.text = "\(self.myModel!.gamesWon)"
        self.EasyHSLabel.text = self.myModel?.easyHS
        self.MediumHSLabel.text = self.myModel?.mediumHS
        self.HardHSLabel.text = self.myModel?.hardHS
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Obtain a reference to the app delegate and model
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        
        //Get stats from storage
        refresh()
    }
    
        //Every time the tab is clicked on, the stats refresh
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }


}
