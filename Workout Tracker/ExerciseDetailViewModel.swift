//
//  ExerciseDetailViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 5/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

struct ExerciseDetailViewModel {
    
    fileprivate let exercise: Exercise!
    
    fileprivate(set) var details = [[(String, String)]]()
    fileprivate(set) var sections = [String]()
    var name: String {
        return exercise.name
    }
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    mutating func displayExerciseDetail() {
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
            if let totalVolumeIncrease = exercise.getPctTotalVolumeIncrease(30), let totalWeightIncrease = exercise.getPctWeightIncrease(30) {
                stats.append(("30d progress", "Weight: \(totalWeightIncrease)%, Total Volume: \(totalVolumeIncrease)%"))
            }
            if let totalVolumeIncrease = exercise.getPctTotalVolumeIncrease(120), let totalWeightIncrease = exercise.getPctWeightIncrease(120) {
                stats.append(("120d progress", "Weight: \(totalWeightIncrease)%, Total Volume: \(totalVolumeIncrease)%"))
            }
            if let pctWeightIncreasePerMonth = exercise.pctWeightIncreasePerMonth, let lbsWeightIncreasePerMonth = exercise.lbsWeightIncreasePerMonth {
                stats.append(("Monthly Avg", "\(pctWeightIncreasePerMonth)%, \(lbsWeightIncreasePerMonth)lbs"))
            }
            stats.append(("1RM", "\(exercise.calculated1RM)lbs"))
            stats.append(("Goal", "\(exercise.goalAttainment)% of \(exercise.goal)lbs"))
            if let averageCycleDays = exercise.averageCycleLength, let averageCycleWorkouts = exercise.workoutsPerCycle {
                stats.append(("Avg Cycle", "\(averageCycleDays) days, \(averageCycleWorkouts) workouts"))
            }
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
            if lastCycleDate.myPrettyString == Date().myPrettyString {
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
    
    func recordWorkout(_ newWorkout: Workout) {
        let lastWorkout = exercise.workoutDiary.last // grab the last workout for later comparison
        
        let realm = try! Realm()
        try! realm.write {
            exercise.workoutDiary.append(newWorkout) // write the workout no matter what
        }
        
        if let secondToLastWorkout = lastWorkout { // only bother checking out of order if there is a last workout...
            if newWorkout.date < secondToLastWorkout.date { // ...and now look to see if they are out of order
                let sortedWorkoutDiary = List(exercise.workoutDiary.sorted(byKeyPath: "date"))
                try! realm.write {
                    exercise.workoutDiary.removeAll()
                    exercise.workoutDiary.append(objectsIn: sortedWorkoutDiary)
                }
            }
        }
    }
    
    func getWorkoutDiary() -> List<Workout> {
        return exercise.workoutDiary
    }
    
    func getExercise() -> Exercise {
        return exercise
    }
    
}
