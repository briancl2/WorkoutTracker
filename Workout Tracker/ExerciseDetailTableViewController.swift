//
//  ExerciseDetailTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift

protocol ExerciseDetailTableViewControllerDelegate {
    func save()
}

class ExerciseDetailTableViewController: UITableViewController, WorkoutHistoryTableViewControllerDelegate {

    var exercise: Exercise!
    
    var exerciseDetails = [[(String, String)]]()
    var exerciseSections = [String]()

    override func viewWillAppear(animated: Bool) {
        displayExerciseDetail()
        self.tableView.reloadData()
        self.title = exercise.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayExerciseDetail()
    }
    
    func displayExerciseDetail() {
        let currentWeights = exercise.currentWeights
        let warmup25Text = ("Warmup (25%)", "\(currentWeights.warmup25.rounded)lbs \(currentWeights.warmup25.barText)")
        let warmup50Text = ("Warmup (50%)", "\(currentWeights.warmup50.rounded)lbs \(currentWeights.warmup50.barText)")
        let heavyText = ("Heavy (100%)", "\(currentWeights.heavy.rounded)lbs \(currentWeights.heavy.barText)")
        
        exerciseDetails = [[warmup25Text, warmup50Text, heavyText]]
        exerciseSections = ["Weights"]
    
    
        if let lastWorkouts = exercise.getLastWorkouts(3) {
            var workoutsToDisplay = [(String, String)]()
            for workout in lastWorkouts {
                workoutsToDisplay.append(("\(workout.date.myPrettyString)", "\(workout.sets[0].repCount) and \(workout.sets[1].repCount) Reps @ \(workout.weight)lbs"))
            }
            exerciseDetails.append(workoutsToDisplay)
            exerciseSections.append("Last Workouts")
            var stats: [(String, String)] = []
            if let totalVolumeIncrease = exercise.getTotalVolumeIncrease(30), let totalWeightIncrease = exercise.getWeightIncrease(30) {
                stats.append(("30d progress", "Weight: \(totalWeightIncrease)% Total Volume: \(totalVolumeIncrease)%"))
            }
            stats.append(("1RM", "\(exercise.calculated1RM)lbs"))
            stats.append(("Goal", "\(exercise.goalAttainment)% of \(exercise.goal)lbs"))
            exerciseDetails.append(stats)
            exerciseSections.append("Stats")
        }
        
//        if let notes = exercise.notes {
//            exerciseDetails.append(["\(notes)"])
//            exerciseSections.append("Notes")
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return exerciseSections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseDetails[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseDetailCell", forIndexPath: indexPath) as! ExerciseDetailTableViewCell
        
        let exerciseDetailText = exerciseDetails[indexPath.section][indexPath.row]
        cell.detailTextLabel?.text = exerciseDetailText.1
        cell.textLabel?.text = exerciseDetailText.0

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exerciseSections[section]
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            if let (lastCycleDate, lastCycleCount) = exercise.lastCycleDate {
                if lastCycleDate.myPrettyString == NSDate().myPrettyString {
                    return "Completed last cycle today!"
                } else if lastCycleCount == 1 {
                    return "Completed last cycle last workout on \(lastCycleDate.myPrettyString)"
                } else {
                    return "Completed last cycle \(lastCycleCount) workouts ago on \(lastCycleDate.myPrettyString)"
                }
            }
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
            
            recordWorkoutTableViewController.exerciseName = exercise.name
            
            if let lastWorkout = exercise.getLastWorkout() {
                recordWorkoutTableViewController.workout = lastWorkout
            }
        } else if segue.identifier == "WorkoutHistory" {
            let workoutHistoryTableViewController = segue.destinationViewController as! WorkoutHistoryTableViewController
            
            workoutHistoryTableViewController.delegate = self
            workoutHistoryTableViewController.exercise = exercise
        }
        
    }
    
    @IBAction func unwindToExerciseDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? RecordWorkoutTableViewController, newWorkout = sourceViewController.newWorkout {
            
            let realm = try! Realm()
            try! realm.write {
                exercise.recordWorkout(newWorkout)
            }
        }
    }
    
    var delegate: ExerciseDetailTableViewControllerDelegate?
    
    func save() {
        delegate?.save()
    }
    
}


