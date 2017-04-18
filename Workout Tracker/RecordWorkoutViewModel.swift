//
//  RecordWorkoutViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 7/9/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

struct RecordWorkoutViewModel {
    
    fileprivate(set) var lastWorkout: Workout?
    fileprivate(set) var exerciseName: String
    
    init(exerciseName: String, lastWorkout: Workout?) {
        self.exerciseName = exerciseName
        self.lastWorkout = lastWorkout
    }
    
    fileprivate struct PropertyKey {
        static let timerCounterKey = "RecordWorkoutTableViewController_timeCount"
        static let timeMeasurementKey = "RecordWorkoutTableViewController_timeMeasurement"
    }
    
    func saveDefaults(_ timerCounter: TimeInterval) {
        let userDefault = UserDefaults.standard
        userDefault.set(timerCounter, forKey: PropertyKey.timerCounterKey)
        userDefault.set(Date().timeIntervalSince1970, forKey: PropertyKey.timeMeasurementKey)
    }
    
    func clearDefaults() {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: PropertyKey.timerCounterKey)
        userDefault.removeObject(forKey: PropertyKey.timeMeasurementKey)
    }
    
    func loadDefaults() -> TimeInterval {
        let userDefault = UserDefaults.standard
        let restoredTimerCounter = userDefault.object(forKey: PropertyKey.timerCounterKey) as! Double
        let restoredTimeMeasurement = userDefault.object(forKey: PropertyKey.timeMeasurementKey) as! Double
        let timeDelta = Date().timeIntervalSince1970 - restoredTimeMeasurement
        
        return restoredTimerCounter - timeDelta
    }
    
}
