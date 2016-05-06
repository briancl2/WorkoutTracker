//
//  ExerciseDetailTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class ExerciseDetailTableViewController: UITableViewController {

    var exercise: Exercise?
    
    var exerciseDetails = [[String]]()
    var exerciseSections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exercise = exercise {
        
            let currentWeights = exercise.currentWeights
            let warmup25Text = "Warmup (25%): \(String(currentWeights.warmup25)) \(exercise.getBarWeightsString(currentWeights.warmup25))"
            let warmup50Text = "Warmup (50%): \(String(currentWeights.warmup50)) \(exercise.getBarWeightsString(currentWeights.warmup50))"
            let heavyText = "Heavy (100%): \(String(currentWeights.heavy)) \(exercise.getBarWeightsString(currentWeights.heavy))"
            
            exerciseDetails.append([warmup25Text, warmup50Text, heavyText])
            exerciseSections.append("Weights")
            
            
            if let notes = exercise.notes {
                exerciseDetails.append(["\(notes)"])
                exerciseSections.append("Notes")
            }
            
//            if let lastWorkoutInRange = exercise.getOldestWorkoutFromRange(15) {
//                exerciseDetails.append("\(NSDateToPrettyString(lastWorkoutInRange.date)) Reps @\(lastWorkoutInRange.sets[0].weight): \(lastWorkoutInRange.sets[0].repCount) and \(lastWorkoutInRange.sets[1].repCount)")
//            }
            
            if let lastWorkout = exercise.getLastWorkout() {
                exerciseDetails.append(["\(NSDateToPrettyString(lastWorkout.date)) Reps @\(lastWorkout.sets[0].weight): \(lastWorkout.sets[0].repCount) and \(lastWorkout.sets[1].repCount)"])
                exerciseSections.append("Last Workout")
                exerciseDetails.append(["15-day total volume increase: \(exercise.getTotalVolumeIncrease(15))%", "Calculated 1RM: \(exercise.getCalculated1RM())lbs", "Goal Attainment: \(exercise.getGoalAttainment())%"])
                exerciseSections.append("Stats")
            }

            
        }

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
