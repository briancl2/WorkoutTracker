//
//  RecordWorkoutViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/2/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class RecordWorkoutViewController: UIViewController {

    @IBOutlet weak var set1TextField: UITextField!
    @IBOutlet weak var set2TextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveWorkout" {
            let exerciseDetailViewController = segue.destinationViewController as! ExerciseDetailViewController
            
            // Get the cell that generated this segue
            if let selectedExerciseCell = sender as? ExerciseTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedExerciseCell)!
                let selectedExercise = exercises!.getExercise(indexPath.row)
                exerciseDetailViewController.exercise = selectedExercise
            }
        }
    }
 
    @IBAction func saveButtonTapped(sender: UIButton) {
    }

}
