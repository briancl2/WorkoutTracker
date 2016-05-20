//
//  WorkoutHistoryTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/18/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

protocol WorkoutHistoryTableViewControllerDelegate {
    func save()
}

class WorkoutHistoryTableViewController: UITableViewController {

    
    var exercise: Exercise!
    var workoutHistory: WorkoutDiary {
        return exercise!.getHistory()!
    }
    
    var workoutToEdit: Workout?
    
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(exercise!.name) History"

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
        return workoutHistory.diary.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutHistoryCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(workoutHistory.diary[indexPath.row].date.myPrettyString)"
        
        cell.detailTextLabel?.text = "\(workoutHistory.diary[indexPath.row].sets[0].repCount) and \(workoutHistory.diary[indexPath.row].sets[1].repCount) Reps @ \(workoutHistory.diary[indexPath.row].sets[0].weight)lbs"
        

        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            workoutHistory.removeWorkout(workoutHistory.diary[indexPath.row])
            save()
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
            workoutToEdit = workoutHistory.getWorkout(indexPath!.row)
            editWorkoutTableViewController.workout = workoutToEdit
            editWorkoutTableViewController.exerciseName = exercise.name
        }
    }

    @IBAction func unwindToWorkoutHistory(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditWorkoutTableViewController, updatedWorkout = sourceViewController.newWorkout {
            exercise.replaceWorkout(workoutToEdit!, newWorkout: updatedWorkout)
            save()
        }
    }
    
    var delegate: WorkoutHistoryTableViewControllerDelegate?
    
    func save() {
        delegate?.save()
    }
    
}
