//
//  ExerciseDetailTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

protocol ExerciseDetailTableViewControllerDelegate {
    func save()
}

class ExerciseDetailTableViewController: UITableViewController {

    var exercise: Exercise!
    
    var exerciseDetails = [[String]]()
    var exerciseSections = [String]()

    override func viewWillAppear(animated: Bool) {
        displayExerciseDetail()
        self.tableView.reloadData()
        self.title = exercise.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayExerciseDetail()
    }
    

    
    func displayExerciseDetail() {
        let currentWeights = exercise.currentWeights
        let warmup25Text = "Warmup (25%): \(currentWeights.warmup25.value)lbs \(currentWeights.warmup25.barText)"
        let warmup50Text = "Warmup (50%): \(currentWeights.warmup50.value)lbs \(currentWeights.warmup50.barText)"
        let heavyText = "Heavy (100%): \(currentWeights.heavy.value)lbs \(currentWeights.heavy.barText)"
        
        exerciseDetails = [[warmup25Text, warmup50Text, heavyText]]
        exerciseSections = ["Weights"]
    
    
        if let lastWorkouts = exercise.getLastWorkouts(3) {
            var workoutsToDisplay = [String]()
            for workout in lastWorkouts {
                workoutsToDisplay.append("\(workout.date.myPrettyString): \(workout.sets[0].repCount) and \(workout.sets[1].repCount) Reps @ \(workout.sets[0].weight)lbs")
            }
            exerciseDetails.append(workoutsToDisplay)
            exerciseSections.append("Last Workouts")
            var stats: [String] = []
            if let totalVolumeIncrease = exercise.getTotalVolumeIncrease(15) {
                stats.append("15-day total volume increase: \(totalVolumeIncrease)%")
            }
            stats.append("Calculated 1RM: \(exercise.calculated1RM)lbs")
            stats.append("Goal Attainment: \(exercise.goalAttainment)% of \(exercise.goal)lbs")
            exerciseDetails.append(stats)
            exerciseSections.append("Stats")
        }
        
        if let notes = exercise.notes {
            exerciseDetails.append(["\(notes)"])
            exerciseSections.append("Notes")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return exerciseSections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exerciseDetails[section].count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell", forIndexPath: indexPath) as! ExerciseDetailTableViewCell
        
        let exerciseDetailText = exerciseDetails[indexPath.section][indexPath.row]
        cell.textLabel?.text = exerciseDetailText

        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exerciseSections[section]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "RecordWorkout" {
            let destination = segue.destinationViewController as! UINavigationController
            let recordWorkoutTableViewController = destination.topViewController as! RecordWorkoutTableViewController
            
            recordWorkoutTableViewController.exerciseName = exercise.name
            
            if let lastWorkout = exercise.getLastWorkout() {
                recordWorkoutTableViewController.workout = lastWorkout
            }

        }
    }
    
    @IBAction func unwindToExerciseDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? RecordWorkoutTableViewController, newWorkout = sourceViewController.newWorkout {
            exercise.recordWorkout(newWorkout)
            save()
        }
    }
    
    var delegate: ExerciseDetailTableViewControllerDelegate?
    
    func save() {
        delegate?.save()
    }
    
}


