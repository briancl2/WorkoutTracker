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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(workoutHistoryViewModel.exerciseName) History"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutHistoryViewModel.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutHistoryCell", for: indexPath)
        
        cell.textLabel?.text = workoutHistoryViewModel.getDate(indexPath.row)
        cell.detailTextLabel?.text = workoutHistoryViewModel.getWorkSets(indexPath.row)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            workoutHistoryViewModel.removeWorkoutAtIndex(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditWorkout" {
            let editWorkoutTableViewController = segue.destination as! EditWorkoutTableViewController
            let selectedWorkoutCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: selectedWorkoutCell)
            let workoutToEdit = workoutHistoryViewModel.getWorkoutAtIndex(indexPath!.row)
            
            editWorkoutTableViewController.workoutToEdit = workoutToEdit
            editWorkoutTableViewController.exerciseName = workoutHistoryViewModel.exerciseName
        }
    }

    @IBAction func unwindToWorkoutHistory(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EditWorkoutTableViewController,
            let oldWorkout = sourceViewController.workoutToEdit,
            let updatedWorkout = sourceViewController.newWorkout {
            workoutHistoryViewModel.replaceWorkout(oldWorkout, newWorkout: updatedWorkout)
        }
    }
}
