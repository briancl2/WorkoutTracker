//
//  WorkoutHistoryViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 5/26/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

struct WorkoutHistoryViewModel {
    private let workoutDiary: List<Workout>
    private let exerciseName: String
    
    var name: String {
        return exerciseName
    }
    
    var count: Int {
        return workoutDiary.count
    }
    
    init(workoutDiary: List<Workout>, exerciseName: String) {
        self.workoutDiary = workoutDiary
        self.exerciseName = exerciseName
    }
    
    func getDate(index: Int) -> String {
        return "\(workoutDiary[index].date.myPrettyString)"
    }
    
    func getWorkSets(index: Int) -> String {
        return "\(workoutDiary[index].sets[0].repCount) and \(workoutDiary[index].sets[1].repCount) Reps @ \(workoutDiary[index].sets[0].weight)lbs"
    }
    
    func removeWorkoutAtIndex(index: Int) {
        let realm = try! Realm()
        try! realm.write {
            workoutDiary.removeAtIndex(index)
        }
    }
    
    func getWorkoutAtIndex(index: Int) -> Workout {
        return workoutDiary[index]
    }
    
    func replaceWorkout(oldWorkout: Workout, newWorkout: Workout) {
        let realm = try! Realm()
        try! realm.write {
            workoutDiary[workoutDiary.indexOf(oldWorkout)!] = newWorkout
        }
    }
}

