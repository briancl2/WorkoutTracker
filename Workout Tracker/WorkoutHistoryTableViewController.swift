//
//  WorkoutHistoryTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/18/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

final class WorkoutHistoryTableViewController: UITableViewController {

    // MARK: Public Properties

    var workoutHistoryViewModel: WorkoutHistoryViewModel!
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(workoutHistoryViewModel.name) History"
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
        return workoutHistoryViewModel.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutHistoryCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = workoutHistoryViewModel.getDate(indexPath.row)
        cell.detailTextLabel?.text = workoutHistoryViewModel.getWorkSets(indexPath.row)
        
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            workoutHistoryViewModel.removeWorkoutAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditWorkout" {
            let editWorkoutTableViewController = segue.destinationViewController as! EditWorkoutTableViewController
            let selectedWorkoutCell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(selectedWorkoutCell)
            let workoutToEdit = workoutHistoryViewModel.getWorkoutAtIndex(indexPath!.row)
            
            editWorkoutTableViewController.workoutToEdit = workoutToEdit
            editWorkoutTableViewController.exerciseName = workoutHistoryViewModel.name
        }
    }

    @IBAction func unwindToWorkoutHistory(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditWorkoutTableViewController,
            oldWorkout = sourceViewController.workoutToEdit,
            updatedWorkout = sourceViewController.newWorkout {
            workoutHistoryViewModel.replaceWorkout(oldWorkout, newWorkout: updatedWorkout)
        }
    }
}
