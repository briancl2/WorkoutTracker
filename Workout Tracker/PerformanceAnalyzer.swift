//
//  PerformanceAnalyzer.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class PerformanceAnalyzer {
    var dayRange = 15
    
    func calcTotalVolumeIncrease(diary: WorkoutDiary, dateRange: Int) -> Int{
        let oldVolume = diary.getOldestWorkoutFromRange(dateRange)!.totalVolume
        let newVolume = diary.getLastWorkout()!.totalVolume
        return Int(100 * (newVolume - oldVolume) / oldVolume)
    }
    
    func calcGoalAttainment(workout: Workout) -> Int {
        let bodyWeight = 162.0
        let goalWeight = bodyWeight * 1.5
        let current1RM = calc1RM(workout)
        
        return Int(100 * (current1RM / goalWeight))
        
        // get current volume with current reps.
        // convert current volume with reps to 1RM
        // return percentage
    }
    
    func calc1RM(workout: Workout) -> Double {

        let weight = Double(workout.sets[0].weight)
        let repCount = workout.sets[0].repCount
        
        let coefficient = [0,1.0,0.943,0.906,0.881,0.856,0.831,0.807,0.786,0.765,0.744,0.723,0.703,0.688,0.675,0.662,0.650,0.638,0.627,0.616,0.606]

        return weight / coefficient[repCount]
        
        
    }
    
}