//
//  ExerciseDetailTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseDetailViewModel {
    var exercise = Exercise()
    
    
    var details = [[(String, String)]]()
    var sections = [String]()
    var name: String {
        return exercise.name
    }
    
    convenience init(exercise: Exercise) {
        self.init()
        self.exercise = exercise
    }
    
    func displayExerciseDetail() {
        let warmup25Text = ("Warmup (25%)", "\(exercise.currentWeights.warmup25.weight)lbs \(exercise.currentWeights.warmup25.barText)")
        let warmup50Text = ("Warmup (50%)", "\(exercise.currentWeights.warmup50.weight)lbs \(exercise.currentWeights.warmup50.barText)")
        let heavyText = ("Heavy (100%)", "\(exercise.currentWeights.heavy.weight)lbs \(exercise.currentWeights.heavy.barText)")
        
        details = [[warmup25Text, warmup50Text, heavyText]]
        sections = ["Weights"]
        
        
        if let lastWorkouts = exercise.getLastWorkouts(3) {
            var workoutsToDisplay = [(String, String)]()
            for workout in lastWorkouts {
                workoutsToDisplay.append(("\(workout.date.myPrettyString)", "\(workout.sets[0].repCount) and \(workout.sets[1].repCount) Reps @ \(workout.weight)lbs"))
            }
            details.append(workoutsToDisplay)
            sections.append("Last Workouts")
            var stats: [(String, String)] = []
            if let totalVolumeIncrease = exercise.getTotalVolumeIncrease(30), let totalWeightIncrease = exercise.getWeightIncrease(30) {
                stats.append(("30d progress", "Weight: \(totalWeightIncrease)% Total Volume: \(totalVolumeIncrease)%"))
            }
            stats.append(("1RM", "\(exercise.calculated1RM)lbs"))
            stats.append(("Goal", "\(exercise.goalAttainment)% of \(exercise.goal)lbs"))
            details.append(stats)
            sections.append("Stats")
        }
        
        //        if let notes = exercise.notes {
        //            exerciseDetails.append(["\(notes)"])
        //            exerciseSections.append("Notes")
        //        }
        
    }
    
    func displayCycleDetail() -> String? {
        if let (lastCycleDate, lastCycleCount) = exercise.lastCycleDate {
            if lastCycleDate.myPrettyString == NSDate().myPrettyString {
                return "Completed cycle today!"
            } else if lastCycleCount == 1 {
                return "Completed cycle last workout on \(lastCycleDate.myPrettyString)"
            } else {
                return "Completed last cycle \(lastCycleCount) workouts ago on \(lastCycleDate.myPrettyString)"
            }
        }
        return nil
    }
    
    func getLastWorkout() -> Workout? {
        return exercise.workoutDiary.last
    }
    
    func recordWorkout(newWorkout: Workout) {
        let realm = try! Realm()
        try! realm.write {
            exercise.workoutDiary.append(newWorkout)
        }
    }
    
}

class ExerciseDetailTableViewController: UITableViewController {

    // MARK: Public Properties
    
    var exerciseDetailViewModel = ExerciseDetailViewModel()

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
            
            workoutHistoryTableViewController.exercise = exerciseDetailViewModel.exercise
        }
        
    }
    
    @IBAction func unwindToExerciseDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? RecordWorkoutTableViewController, newWorkout = sourceViewController.newWorkout {
            
            exerciseDetailViewModel.recordWorkout(newWorkout)

        }
    }
}


