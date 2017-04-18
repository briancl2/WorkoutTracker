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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        return exercisesViewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ExerciseTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExerciseTableViewCell
        let exercise = exercisesViewModel.getExercise(indexPath.row)
        cell.textLabel!.text = exercise.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exercisesViewModel.removeExerciseAtIndex(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {

    }



    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }



    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExerciseDetail" {
            let exerciseDetailTableViewController = segue.destination as! ExerciseDetailTableViewController
            
            if let selectedExerciseCell = sender as? ExerciseTableViewCell {
                let indexPath = tableView.indexPath(for: selectedExerciseCell)!
                let selectedExercise = exercisesViewModel.getExercise(indexPath.row)
                exerciseDetailTableViewController.exerciseDetailViewModel = ExerciseDetailViewModel(exercise: selectedExercise)
            }
        }
    }
    
    @IBAction func unwindToExerciseList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddExerciseTableViewController, let exercise = sourceViewController.exercise {
            let newIndexPath = IndexPath(row: exercisesViewModel.count, section: 0)
            exercisesViewModel.addExercise(exercise)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
        }
    }
    



}
