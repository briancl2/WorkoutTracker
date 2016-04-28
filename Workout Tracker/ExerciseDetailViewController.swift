//
//  ExerciseDetailViewController.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController  {

    @IBOutlet weak var display: UILabel!

    // This value is either passed by `ExerciseTableViewController` in `prepareForSegue(_:sender:)`
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        displayExercise()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayExercise() {
        if let exercise = exercise {
            navigationItem.title = exercise.name
            let currentWeights = exercise.currentWeights
            let formNotes = exercise.formNotes!
            let warmup25Text = String(currentWeights.warmup25) + " " + exercise.getBarWeightsString(currentWeights.warmup25)
            let warmup50Text = String(currentWeights.warmup50) + " " + exercise.getBarWeightsString(currentWeights.warmup50)
            let heavyText = String(currentWeights.heavy) + " " + exercise.getBarWeightsString(currentWeights.heavy)
            
            display.text! = "Form Notes:\n"
            display.text! += "\(formNotes)\n"
            display.text! += "Warmup (25%): \(warmup25Text)\n"
            display.text! += "Warmup (50%): \(warmup50Text)\n"
            display.text! += "Heavy (100%): \(heavyText)\n"
            
            if let lastWorkout = exercise.getLastWorkout() {
                display.text! += "\(lastWorkout["date"]!) Reps @\(lastWorkout["weight"]!): \(lastWorkout["repsFirstSet"]!) and \(lastWorkout["repsSecondSet"]!)\n)"
            }
        }
    }
}

