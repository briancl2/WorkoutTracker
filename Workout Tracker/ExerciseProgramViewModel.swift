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
    private var exercises = ExerciseProgram()
    var count: Int {
        return exercises.program.count
    }
    
    init() {
        LoadDataDefaults()
        let realm = try! Realm()
        if let savedExerciseProgram = realm.objects(ExerciseProgram).first {
            self.exercises = savedExerciseProgram
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    func getExercise(index: Int) -> Exercise {
        return exercises.program[index]
    }
    
    func removeExerciseAtIndex(index: Int) {
        let realm = try! Realm()
        try! realm.write {
            exercises.program.removeAtIndex(index)
        }
    }
    
    func addExercise(newExercise: Exercise) {
        let realm = try! Realm()
        try! realm.write {
            exercises.program.append(newExercise)
        }
    }
    
//    func updateExercise(index: Int, updatedExercise: Exercise) {
//        let realm = try! Realm()
//        try! realm.write {
//            exercises.program[index] = updatedExercise
//        }
//    }
}
