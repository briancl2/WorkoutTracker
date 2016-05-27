//
//  ExerciseDetailTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class ExerciseDetailTableViewController: UITableViewController {

    // MARK: Public Properties
    
    var exerciseDetailViewModel: ExerciseDetailViewModel!

    // MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        exerciseDetailViewModel.displayExerciseDetail()
        self.tableView.reloadData()
        self.title = exerciseDetailViewModel.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return exerciseDetailViewModel.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseDetailViewModel.details[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell", forIndexPath: indexPath) as! ExerciseDetailTableViewCell
        
        let exerciseDetailText = exerciseDetailViewModel.details[indexPath.section][indexPath.row]
        cell.detailTextLabel?.text = exerciseDetailText.1
        cell.textLabel?.text = exerciseDetailText.0
        
        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exerciseDetailViewModel.sections[section]
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return exerciseDetailViewModel.displayCycleDetail()
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RecordWorkout" {
            let navController = segue.destinationViewController as! UINavigationController
            let recordWorkoutTableViewController = navController.topViewController as! RecordWorkoutTableViewController
            
            recordWorkoutTableViewController.exerciseName = exerciseDetailViewModel.name
            
            if let lastWorkout = exerciseDetailViewModel.getLastWorkout() {
                recordWorkoutTableViewController.workout = lastWorkout
            }
        } else if segue.identifier == "WorkoutHistory" {
            let workoutHistoryTableViewController = segue.destinationViewController as! WorkoutHistoryTableViewController
            
            workoutHistoryTableViewController.workoutHistoryViewModel = WorkoutHistoryViewModel(workoutDiary: exerciseDetailViewModel.getWorkoutDiary(), exerciseName: exerciseDetailViewModel.name)
            
        }
        
    }
    
    @IBAction func unwindToExerciseDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? RecordWorkoutTableViewController, newWorkout = sourceViewController.newWorkout {
            
            exerciseDetailViewModel.recordWorkout(newWorkout)

        }
    }
}


