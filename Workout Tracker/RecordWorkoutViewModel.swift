//
//  RecordWorkoutViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 7/9/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

struct RecordWorkoutViewModel {
    
    private(set) var lastWorkout: Workout?
    private(set) var exerciseName: String
    
    init(exerciseName: String, lastWorkout: Workout?) {
        self.exerciseName = exerciseName
        self.lastWorkout = lastWorkout
    }
    
    private struct PropertyKey {
        static let timerCounterKey = "RecordWorkoutTableViewController_timeCount"
        static let timeMeasurementKey = "RecordWorkoutTableViewController_timeMeasurement"
    }
    
    func saveDefaults(timerCounter: NSTimeInterval) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(timerCounter, forKey: PropertyKey.timerCounterKey)
        userDefault.setObject(NSDate().timeIntervalSince1970, forKey: PropertyKey.timeMeasurementKey)
    }
    
    func clearDefaults() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.removeObjectForKey(PropertyKey.timerCounterKey)
        userDefault.removeObjectForKey(PropertyKey.timeMeasurementKey)
    }
    
    func loadDefaults() -> NSTimeInterval {
        let userDefault = NSUserDefaults.standardUserDefaults()
        let restoredTimerCounter = userDefault.objectForKey(PropertyKey.timerCounterKey) as! Double
        let restoredTimeMeasurement = userDefault.objectForKey(PropertyKey.timeMeasurementKey) as! Double
        let timeDelta = NSDate().timeIntervalSince1970 - restoredTimeMeasurement
        
        return restoredTimerCounter - timeDelta
    }
    
}