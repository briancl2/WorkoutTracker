//
//  ExerciseProgramTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

final class ExerciseProgramTableViewController: UITableViewController {

    // MARK: Public Properties
    
    let exercisesViewModel = ExerciseProgramViewModel()
    
    // MARK: View Lifecycle
    
//    override func viewWillAppear(animated: Bool) {
//        tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
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
        return exercisesViewModel.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ExerciseTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExerciseTableViewCell
        let exercise = exercisesViewModel.getExercise(indexPath.row)
        cell.textLabel!.text = exercise.name
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            exercisesViewModel.removeExerciseAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowExerciseDetail" {
            let exerciseDetailTableViewController = segue.destinationViewController as! ExerciseDetailTableViewController
            
            if let selectedExerciseCell = sender as? ExerciseTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedExerciseCell)!
                let selectedExercise = exercisesViewModel.getExercise(indexPath.row)
                exerciseDetailTableViewController.exerciseDetailViewModel = ExerciseDetailViewModel(exercise: selectedExercise)
            }
        }
    }
    
    @IBAction func unwindToExerciseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddExerciseTableViewController, exercise = sourceViewController.exercise {
            let newIndexPath = NSIndexPath(forRow: exercisesViewModel.count, inSection: 0)
            exercisesViewModel.addExercise(exercise)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    



}
