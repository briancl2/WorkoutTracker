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
    private let exercises: Results<Exercise>
    var count: Int {
        return exercises.count
    }
    
    init() {
        LoadDataDefaults()
        let realm = try! Realm()
        let savedExerciseProgram = realm.objects(Exercise)
        self.exercises = savedExerciseProgram
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    func getExercise(index: Int) -> Exercise {
        return exercises[index]
    }
    
    func removeExerciseAtIndex(index: Int) {
        let exercise = exercises[index]
        let realm = try! Realm()
        try! realm.write {
            realm.delete(exercise)
        }
    }
    
    func addExercise(newExercise: Exercise) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(newExercise)
        }
    }
    
//    func updateExercise(index: Int, updatedExercise: Exercise) {
//        let realm = try! Realm()
//        try! realm.write {
//            exercises.program[index] = updatedExercise
//        }
//    }
}
