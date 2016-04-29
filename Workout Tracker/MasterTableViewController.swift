//
//  MasterTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {

    var exercises = ExerciseProgram(name: "temp", startDate: "temp", program: [])
    
    override func viewWillAppear(animated: Bool) {
        // Load any saved program, otherwise load sample data.
        if let savedProgram = loadProgram() {
            exercises = savedProgram
        } else {
            // Load the sample data.
            loadSampleProgram()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleProgram() {
        let squat = Exercise(name: "Squat", notes: "Squat notes", workoutDiary: WorkoutDiary(diary: []), weight: 0)
        squat.recordWorkout("16-04-20", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        squat.recordWorkout("16-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        squat.recordWorkout("16-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
        squat.recordWorkout("16-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
        squat.recordWorkout("16-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
        
        let bench = Exercise(name: "Bench Press", notes: "Bench Press notes", workoutDiary: WorkoutDiary(diary: []), weight: 0)
        bench.recordWorkout("16-04-20", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
        bench.recordWorkout("16-04-22", weight: 135, repsFirstSet: 9, repsSecondSet: 7)
        bench.recordWorkout("16-04-25", weight: 135, repsFirstSet: 9, repsSecondSet: 8)
        bench.recordWorkout("16-04-27", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
        bench.recordWorkout("16-04-29", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
        
        let row = Exercise(name: "Bent Over Row", notes: "Bent Over Row notes", workoutDiary: WorkoutDiary(diary: []), weight: 0)
        row.recordWorkout("16-04-20", weight: 115, repsFirstSet: 11, repsSecondSet: 10)
        row.recordWorkout("16-04-22", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
        row.recordWorkout("16-04-25", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
        row.recordWorkout("16-04-27", weight: 115, repsFirstSet: 12, repsSecondSet: 10)
        row.recordWorkout("16-04-29", weight: 115, repsFirstSet: 13, repsSecondSet: 10)
        
        exercises = ExerciseProgram(name: "Allpro Auto-regulated", startDate: "16-04-20", program: [])
        
        exercises!.addExercise(bench)
        exercises!.addExercise(squat)
        exercises!.addExercise(row)
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
        return exercises!.getCount()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ExerciseTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExerciseTableViewCell
        // Fetches the appropriate exercise for the data source layout
        let exercise = exercises?.getExercise(indexPath.row)
        cell.textLabel!.text = exercise!.name

        // Configure the cell...
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            exercises!.removeExercise(indexPath.row)
            saveProgram()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } //else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //    }
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let exerciseDetailViewController = segue.destinationViewController as! ExerciseDetailViewController
            
            // Get the cell that generated this segue
            if let selectedExerciseCell = sender as? ExerciseTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedExerciseCell)!
                let selectedExercise = exercises!.getExercise(indexPath.row)
                exerciseDetailViewController.exercise = selectedExercise
            }
        }
    }
    
    @IBAction func unwindToExerciseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddExerciseViewController, exercise = sourceViewController.exercise {
            // Add a new exercise.
            let newIndexPath = NSIndexPath(forRow: exercises!.getCount(), inSection: 0)
            exercises!.addExercise(exercise)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            saveProgram()
        }
    }
    
    // MARK: NSCoding
    
    func saveProgram() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(exercises!), forKey: "MasterTableViewController_program")
        defaults.synchronize()
    }
    
    func loadProgram() -> ExerciseProgram? {
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let decodedNSData = defaults.objectForKey("MasterTableViewController_program") as? NSData,
            let exerciseProgram = NSKeyedUnarchiver.unarchiveObjectWithData(decodedNSData) as? ExerciseProgram
            else {
                print("Failed")
                return nil
        }
        return exerciseProgram
    }


}
