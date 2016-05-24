//
//  WorkoutHistoryTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/18/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift

class WorkoutHistoryTableViewController: UITableViewController {

    // MARK: Public Properties
    
    var exercise = Exercise()
    var workoutToEdit = Workout()
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(exercise.name) History"

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercise.workoutDiary.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutHistoryCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(exercise.workoutDiary[indexPath.row].date.myPrettyString)"
        
        cell.detailTextLabel?.text = "\(exercise.workoutDiary[indexPath.row].sets[0].repCount) and \(exercise.workoutDiary[indexPath.row].sets[1].repCount) Reps @ \(exercise.workoutDiary[indexPath.row].sets[0].weight)lbs"
        

        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let realm = try! Realm()
            try! realm.write {
                exercise.workoutDiary.removeAtIndex(indexPath.row)
            }
            //save()
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditWorkout" {
            let editWorkoutTableViewController = segue.destinationViewController as! EditWorkoutTableViewController
            
            let selectedWorkoutCell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(selectedWorkoutCell)
            workoutToEdit = exercise.workoutDiary[indexPath!.row]
            editWorkoutTableViewController.workout = workoutToEdit
            editWorkoutTableViewController.exerciseName = exercise.name
        }
    }

    @IBAction func unwindToWorkoutHistory(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditWorkoutTableViewController, updatedWorkout = sourceViewController.newWorkout {

            let realm = try! Realm()
            try! realm.write {
                exercise.replaceWorkout(workoutToEdit, newWorkout: updatedWorkout)
            }
        }
    }
}
