//
//  MasterTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 4/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, ExerciseDetailTableViewControllerDelegate {

    var exercises = ExerciseProgram(name: "temp", startDate: "temp", program: [], userProfile: User(bodyWeight: 0, name: ""))
    
    override func viewWillAppear(animated: Bool) {
        // Load any saved program, otherwise load sample data.
        if let savedProgram = load() {
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
        let squat = Exercise(name: "Squat", notes: "Squat notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 320)
        squat.recordWorkout("16-04-19", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        squat.recordWorkout("16-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        squat.recordWorkout("16-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
        squat.recordWorkout("16-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
        squat.recordWorkout("16-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
        squat.recordWorkout("16-05-02", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
        squat.recordWorkout("16-05-05", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
        squat.recordWorkout("16-05-07", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
        squat.recordWorkout("16-05-09", weight: 145, repsFirstSet: 12, repsSecondSet: 11)
        squat.recordWorkout("16-05-12", weight: 145, repsFirstSet: 13, repsSecondSet: 11)
        squat.recordWorkout("16-05-14", weight: 155, repsFirstSet: 9, repsSecondSet: 7)
        squat.recordWorkout("16-05-16", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
        squat.recordWorkout("16-05-18", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
        
        let bench = Exercise(name: "Bench Press", notes: "Bench Press notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 240)
        bench.recordWorkout("16-04-19", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
        bench.recordWorkout("16-04-22", weight: 135, repsFirstSet: 9, repsSecondSet: 7)
        bench.recordWorkout("16-04-25", weight: 135, repsFirstSet: 9, repsSecondSet: 8)
        bench.recordWorkout("16-04-27", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
        bench.recordWorkout("16-04-29", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
        bench.recordWorkout("16-05-02", weight: 135, repsFirstSet: 10, repsSecondSet: 9)
        bench.recordWorkout("16-05-05", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
        bench.recordWorkout("16-05-07", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
        bench.recordWorkout("16-05-09", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
        bench.recordWorkout("16-05-12", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
        bench.recordWorkout("16-05-14", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
        bench.recordWorkout("16-05-16", weight: 135, repsFirstSet: 12, repsSecondSet: 11)
        bench.recordWorkout("16-05-18", weight: 135, repsFirstSet: 13, repsSecondSet: 10)
        
        let row = Exercise(name: "Bent Over Row", notes: "Bent Over Row notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 240)
        row.recordWorkout("16-04-19", weight: 115, repsFirstSet: 11, repsSecondSet: 10)
        row.recordWorkout("16-04-22", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
        row.recordWorkout("16-04-25", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
        row.recordWorkout("16-04-27", weight: 115, repsFirstSet: 12, repsSecondSet: 10)
        row.recordWorkout("16-04-29", weight: 115, repsFirstSet: 13, repsSecondSet: 10)
        row.recordWorkout("16-05-02", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
        row.recordWorkout("16-05-05", weight: 125, repsFirstSet: 9, repsSecondSet: 8)
        row.recordWorkout("16-05-07", weight: 125, repsFirstSet: 9, repsSecondSet: 9)
        row.recordWorkout("16-05-09", weight: 125, repsFirstSet: 10, repsSecondSet: 9)
        row.recordWorkout("16-05-12", weight: 125, repsFirstSet: 10, repsSecondSet: 10)
        row.recordWorkout("16-05-14", weight: 125, repsFirstSet: 11, repsSecondSet: 10)
        row.recordWorkout("16-05-16", weight: 125, repsFirstSet: 12, repsSecondSet: 10)
        row.recordWorkout("16-05-18", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
        
        let ohp = Exercise(name: "Overhead Press", notes: "OHP notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 160)
        ohp.recordWorkout("16-04-19", weight: 95, repsFirstSet: 8, repsSecondSet: 8)
        ohp.recordWorkout("16-04-22", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-04-25", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-04-27", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-04-29", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-05-02", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-05", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-07", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-09", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-12", weight: 95, repsFirstSet: 10, repsSecondSet: 9)
        ohp.recordWorkout("16-05-14", weight: 95, repsFirstSet: 10, repsSecondSet: 10)
        ohp.recordWorkout("16-05-16", weight: 95, repsFirstSet: 10, repsSecondSet: 10)
        ohp.recordWorkout("16-05-18", weight: 95, repsFirstSet: 11, repsSecondSet: 8)
        
        let sldl = Exercise(name: "Straight Leg Deadlift", notes: "SLDL notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 240)
        sldl.recordWorkout("16-04-19", weight: 95, repsFirstSet: 13, repsSecondSet: 11)
        sldl.recordWorkout("16-04-22", weight: 95, repsFirstSet: 13, repsSecondSet: 12)
        sldl.recordWorkout("16-04-25", weight: 105, repsFirstSet: 9, repsSecondSet: 8)
        sldl.recordWorkout("16-04-27", weight: 105, repsFirstSet: 10, repsSecondSet: 10)
        sldl.recordWorkout("16-04-29", weight: 105, repsFirstSet: 11, repsSecondSet: 10)
        sldl.recordWorkout("16-05-02", weight: 105, repsFirstSet: 12, repsSecondSet: 11)
        sldl.recordWorkout("16-05-05", weight: 105, repsFirstSet: 12, repsSecondSet: 11)
        sldl.recordWorkout("16-05-07", weight: 105, repsFirstSet: 13, repsSecondSet: 11)
        sldl.recordWorkout("16-05-09", weight: 115, repsFirstSet: 9, repsSecondSet: 8)
        sldl.recordWorkout("16-05-12", weight: 115, repsFirstSet: 10, repsSecondSet: 9)
        sldl.recordWorkout("16-05-14", weight: 115, repsFirstSet: 11, repsSecondSet: 10)
        sldl.recordWorkout("16-05-16", weight: 115, repsFirstSet: 12, repsSecondSet: 10)
        sldl.recordWorkout("16-05-18", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
        
        let chin = Exercise(name: "Chin-up", notes: "Chin notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 240)
        chin.recordWorkout("16-04-19", weight: 110, repsFirstSet: 10, repsSecondSet: 9)
        chin.recordWorkout("16-04-22", weight: 110, repsFirstSet: 10, repsSecondSet: 9)
        chin.recordWorkout("16-04-25", weight: 110, repsFirstSet: 10, repsSecondSet: 10)
        chin.recordWorkout("16-04-27", weight: 110, repsFirstSet: 11, repsSecondSet: 10)
        chin.recordWorkout("16-04-29", weight: 110, repsFirstSet: 11, repsSecondSet: 10)
        chin.recordWorkout("16-05-05", weight: 110, repsFirstSet: 11, repsSecondSet: 11)
        chin.recordWorkout("16-05-07", weight: 110, repsFirstSet: 11, repsSecondSet: 11)
        chin.recordWorkout("16-05-09", weight: 110, repsFirstSet: 12, repsSecondSet: 11)
        chin.recordWorkout("16-05-12", weight: 110, repsFirstSet: 13, repsSecondSet: 11)
        chin.recordWorkout("16-05-14", weight: 110, repsFirstSet: 13, repsSecondSet: 11)
        chin.recordWorkout("16-05-16", weight: 120, repsFirstSet: 11, repsSecondSet: 9)
        chin.recordWorkout("16-05-18", weight: 120, repsFirstSet: 11, repsSecondSet: 9)
        
        let calf = Exercise(name: "Calf Raise", notes: "calf notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 320)
        calf.recordWorkout("16-04-19", weight: 150, repsFirstSet: 13, repsSecondSet: 11)
        calf.recordWorkout("16-04-22", weight: 175, repsFirstSet: 10, repsSecondSet: 8)
        calf.recordWorkout("16-04-25", weight: 175, repsFirstSet: 10, repsSecondSet: 10)
        calf.recordWorkout("16-04-27", weight: 175, repsFirstSet: 11, repsSecondSet: 10)
        calf.recordWorkout("16-04-29", weight: 175, repsFirstSet: 11, repsSecondSet: 11)
        calf.recordWorkout("16-05-05", weight: 175, repsFirstSet: 12, repsSecondSet: 11)
        calf.recordWorkout("16-05-09", weight: 175, repsFirstSet: 12, repsSecondSet: 11)
        calf.recordWorkout("16-05-12", weight: 175, repsFirstSet: 13, repsSecondSet: 11)
        calf.recordWorkout("16-05-16", weight: 195, repsFirstSet: 9, repsSecondSet: 8)
        calf.recordWorkout("16-05-18", weight: 195, repsFirstSet: 10, repsSecondSet: 9)
        
        let torso = Exercise(name: "Torso Rotation", notes: "torso notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 240)
        torso.recordWorkout("16-04-19", weight: 130, repsFirstSet: 13, repsSecondSet: 11)
        torso.recordWorkout("16-04-22", weight: 140, repsFirstSet: 9, repsSecondSet: 9)
        torso.recordWorkout("16-04-25", weight: 140, repsFirstSet: 11, repsSecondSet: 9)
        torso.recordWorkout("16-04-27", weight: 140, repsFirstSet: 10, repsSecondSet: 10)
        torso.recordWorkout("16-04-29", weight: 140, repsFirstSet: 11, repsSecondSet: 10)
        torso.recordWorkout("16-05-05", weight: 140, repsFirstSet: 11, repsSecondSet: 10)
        torso.recordWorkout("16-05-07", weight: 140, repsFirstSet: 11, repsSecondSet: 11)
        torso.recordWorkout("16-05-09", weight: 140, repsFirstSet: 11, repsSecondSet: 11)
        torso.recordWorkout("16-05-12", weight: 140, repsFirstSet: 12, repsSecondSet: 11)
        torso.recordWorkout("16-05-14", weight: 140, repsFirstSet: 12, repsSecondSet: 11)
        torso.recordWorkout("16-05-16", weight: 140, repsFirstSet: 13, repsSecondSet: 11)
        
        let curl = Exercise(name: "Curl", notes: "curl notes", workoutDiary: WorkoutDiary(diary: []), weight: 0, goal: 120)
        curl.recordWorkout("16-04-19", weight: 50, repsFirstSet: 11, repsSecondSet: 8)
        curl.recordWorkout("16-04-22", weight: 50, repsFirstSet: 11, repsSecondSet: 9)
        curl.recordWorkout("16-04-25", weight: 50, repsFirstSet: 12, repsSecondSet: 10)
        curl.recordWorkout("16-04-27", weight: 50, repsFirstSet: 12, repsSecondSet: 10)
        curl.recordWorkout("16-04-29", weight: 50, repsFirstSet: 12, repsSecondSet: 11)
        curl.recordWorkout("16-05-05", weight: 50, repsFirstSet: 13, repsSecondSet: 11)
        curl.recordWorkout("16-05-07", weight: 60, repsFirstSet: 9, repsSecondSet: 8)
        curl.recordWorkout("16-05-09", weight: 60, repsFirstSet: 9, repsSecondSet: 9)
        curl.recordWorkout("16-05-12", weight: 60, repsFirstSet: 10, repsSecondSet: 9)
        curl.recordWorkout("16-05-14", weight: 60, repsFirstSet: 10, repsSecondSet: 9)
        curl.recordWorkout("16-05-16", weight: 60, repsFirstSet: 11, repsSecondSet: 9)
        curl.recordWorkout("16-05-16", weight: 60, repsFirstSet: 12, repsSecondSet: 9)
        
        exercises = ExerciseProgram(name: "Allpro Auto-regulated", startDate: "16-04-20", program: [], userProfile: User(bodyWeight: 160, name: "Brian"))
        
        exercises!.addExercise(squat)
        exercises!.addExercise(bench)
        exercises!.addExercise(row)
        exercises!.addExercise(ohp)
        exercises!.addExercise(sldl)
        exercises!.addExercise(chin)
        exercises!.addExercise(calf)
        exercises!.addExercise(torso)
        exercises!.addExercise(curl)
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
            save()
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
        if segue.identifier == "ShowExerciseDetail" {
            let exerciseDetailTableViewController = segue.destinationViewController as! ExerciseDetailTableViewController
            
            exerciseDetailTableViewController.delegate = self
            
            // Get the cell that generated this segue
            if let selectedExerciseCell = sender as? ExerciseTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedExerciseCell)!
                let selectedExercise = exercises!.getExercise(indexPath.row)
                exerciseDetailTableViewController.exercise = selectedExercise
            }
        }
    }
    
    @IBAction func unwindToExerciseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddExerciseTableViewController, exercise = sourceViewController.exercise {
            // Add a new exercise.
            let newIndexPath = NSIndexPath(forRow: exercises!.getCount(), inSection: 0)
            exercises!.addExercise(exercise)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            save()
        }
    }
    
    // MARK: NSCoding
    
    func save() {
        exercises?.saveProgram()
    }
    
    func load() -> ExerciseProgram? {
        return exercises?.loadProgram()
    }


}
