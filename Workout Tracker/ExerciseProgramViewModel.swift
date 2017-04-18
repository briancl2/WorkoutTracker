//
//  ExerciseProgramViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 5/25/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

struct ExerciseProgramViewModel {
    
    fileprivate let exercises: Results<Exercise>
    var count: Int {
        return exercises.count
    }
    
    init() {
        //LoadDataDefaults()
        let realm = try! Realm()
        self.exercises = realm.objects(Exercise.self).sorted(byKeyPath: "sortOrder")
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    func getExercise(_ index: Int) -> Exercise {
        return exercises[index]
    }
    
    func removeExerciseAtIndex(_ index: Int) {
        let exercise = exercises[index]
        let realm = try! Realm()
        try! realm.write {
            for workout in exercise.workoutDiary {
                for workSet in workout.sets {
                    realm.delete(workSet)
                }
                realm.delete(workout)
            }
            realm.delete(exercise)
        }
    }
    
    func addExercise(_ newExercise: Exercise) {
        if let lastExercise = exercises.last {
            newExercise.sortOrder = lastExercise.sortOrder + 1
        }
        let realm = try! Realm()
        try! realm.write {
            realm.add(newExercise)
        }
    }
    
}
