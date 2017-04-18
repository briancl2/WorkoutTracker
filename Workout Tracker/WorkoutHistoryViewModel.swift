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
    
    fileprivate var workoutDiary: List<Workout>
    let exerciseName: String
    
    var count: Int {
        return workoutDiary.count
    }
    
    init(workoutDiary: List<Workout>, exerciseName: String) {
        self.workoutDiary = workoutDiary
        self.exerciseName = exerciseName
    }
    
    func getDate(_ index: Int) -> String {
        return "\(workoutDiary[index].date.myPrettyString)"
    }
    
    func getWorkSets(_ index: Int) -> String {
        return "\(workoutDiary[index].sets[0].repCount) and \(workoutDiary[index].sets[1].repCount) Reps @ \(workoutDiary[index].sets[0].weight)lbs"
    }
    
    mutating func removeWorkoutAtIndex(_ index: Int) {
        let realm = try! Realm()
        try! realm.write {
            workoutDiary.remove(at: index)
        }
    }
    
    func getWorkoutAtIndex(_ index: Int) -> Workout {
        return workoutDiary[index]
    }
    
    func replaceWorkout(_ oldWorkout: Workout, newWorkout: Workout) {
        let index = workoutDiary.index(of: oldWorkout)!
        
        let realm = try! Realm()
        try! realm.write {
            workoutDiary.replace(index: index, object: newWorkout)
        }
        
        if index != 0 {
            if workoutDiary[index].date < workoutDiary[index - 1].date  {
                let sortedWorkoutDiary = List(workoutDiary.sorted(byKeyPath: "date"))
                try! realm.write {
                    workoutDiary.removeAll()
                    workoutDiary.append(objectsIn: sortedWorkoutDiary)
                }
            }
        }
        
        if index != workoutDiary.count - 1 {
            if workoutDiary[index].date > workoutDiary[index + 1].date {
                let sortedWorkoutDiary = List(workoutDiary.sorted(byKeyPath: "date"))
                try! realm.write {
                    workoutDiary.removeAll()
                    workoutDiary.append(objectsIn: sortedWorkoutDiary)
                }
            }
        }
    }
    
}

