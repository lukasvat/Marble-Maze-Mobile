//
//  Model.swift
//  RollingLabyrinth

// Lukas Vatistas (lvatista@iu.edu)
// Connor Hands(cahands@iu.edu)
// Project Name: MarbleMazeMobile
// A04 submission date: 4/12/24
// A05 submission date: 4/19/24

import Foundation
import UIKit
import CoreData

class RollingLabyrinthModel{
    
    // Time Vairable
    var timerCounting: Bool = false
    var resetTimer: Bool = false
    var updateHighScore: Bool = false
    var savedTimerString: String = ""
    var savedTimerInt: Int = 0
    
    //Statistic Variables
    var gamesPlayed: Int = 0
    var gamesWon: Int = 0
    var easyHS: String = "00:00"
    var easyHSInt: Int = Int.max
    var mediumHS: String = "00:00"
    var mediumHSInt: Int = Int.max
    var hardHS: String = "00:00"
    var hardHSInt: Int = Int.max
    
    //Setting varaibles
    var difficulty: Int = 1///1=easy, 2=medium, 3=hard
    var ballColor: String = "red"
    var backgroundColor: UIColor = UIColor.systemGray2
    var backgroundColorString = "grey"
    
    func colorToString() -> String{
        if(backgroundColor == UIColor.green){
            backgroundColorString = "green"
            return "green"
        }
        else if(backgroundColor == UIColor.blue){
            backgroundColorString = "blue"
            return "blue"
        }
        else if(backgroundColor == UIColor.red){
            backgroundColorString = "red"
            return "red"
        }
        else{
            backgroundColorString = "grey"
            return "grey"
        }
    }
    
    func stringToColor() -> UIColor{
        if(backgroundColorString == "green"){
            backgroundColor = UIColor.green
            return UIColor.green
        }
        else if(backgroundColorString == "blue"){
            backgroundColor = UIColor.blue
            return UIColor.blue
        }
        else if(backgroundColorString == "red"){
            backgroundColor = UIColor.red
            return UIColor.red
        }
        else{
            backgroundColor = UIColor.systemGray2
            return UIColor.systemGray2
        }
    }
    

    
    func saveStatisticsToCoreData() {
        print("saving to coredata")
        let context = CoreDataManager.shared.context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
        
        do {
            let results = try context.fetch(fetchRequest)
            let gameStats: NSManagedObject
            
            if results.isEmpty {
                // If no record exists, create a new one
                gameStats = NSEntityDescription.insertNewObject(forEntityName: "Model", into: context)
            } else {
                // If a record exists, update the first one
                gameStats = results.first!
            }
            
            // Update the values
            gameStats.setValue(gamesPlayed, forKey: "gamesPlayed")
            gameStats.setValue(gamesWon, forKey: "gamesWon")
            gameStats.setValue(easyHS, forKey: "easyHS")
            gameStats.setValue(easyHSInt, forKey: "easyHSInt")
            gameStats.setValue(mediumHS, forKey: "medHS")
            gameStats.setValue(mediumHSInt, forKey: "medHSInt")
            gameStats.setValue(hardHS, forKey: "hardHS")
            gameStats.setValue(hardHSInt, forKey: "hardHSInt")
            gameStats.setValue(ballColor, forKey: "ballColor")
            gameStats.setValue(difficulty, forKey: "difficulty")
            gameStats.setValue(colorToString(), forKey: "backgroundColor")
            
            // Save the context
            CoreDataManager.shared.saveContext()
            print("Data saved successfully")
        } catch {
            print("Failed to save statistics: \(error)")
        }
    }
    func loadStatisticsFromCoreData() {
        print("Loading from CoreData")
        let context = CoreDataManager.shared.context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let gameStats = results.first {
                // Update the model with the loaded values
                gamesPlayed = gameStats.value(forKey: "gamesPlayed") as? Int ?? 0
                gamesWon = gameStats.value(forKey: "gamesWon") as? Int ?? 0
                easyHS = gameStats.value(forKey: "easyHS") as? String ?? "00:00"
                easyHSInt = gameStats.value(forKey: "easyHSInt") as? Int ?? Int.max
                mediumHS = gameStats.value(forKey: "medHS") as? String ?? "00:00"
                mediumHSInt = gameStats.value(forKey: "medHSInt") as? Int ?? Int.max
                hardHS = gameStats.value(forKey: "hardHS") as? String ?? "00:00"
                hardHSInt = gameStats.value(forKey: "hardHSInt") as? Int ?? Int.max
                ballColor = gameStats.value(forKey: "ballColor") as? String ?? "red"
                difficulty = gameStats.value(forKey: "difficulty") as? Int ?? 1
                backgroundColorString = gameStats.value(forKey: "backgroundColor") as? String ?? "gray"
                backgroundColor = stringToColor()
            }
        } catch {
            print("Failed to load statistics: \(error)")
        }
    }
}
