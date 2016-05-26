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
        let realm = try! Realm()
        if let savedExerciseProgram = realm.objects(ExerciseProgram).first {
            self.exercises = savedExerciseProgram
        } else {
            loadSampleData()
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    private mutating func loadSampleData() {
        let squat = Exercise(name: "Squat", notes: "Squat notes", workoutDiary: List<Workout>(), goal: 320)
        squat.recordWorkout("16-04-20", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        squat.recordWorkout("16-04-22", weight: 145, repsFirstSet: 10, repsSecondSet: 9)
        squat.recordWorkout("16-04-25", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
        squat.recordWorkout("16-04-27", weight: 145, repsFirstSet: 10, repsSecondSet: 10)
        squat.recordWorkout("16-04-29", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
        squat.recordWorkout("16-05-02", weight: 145, repsFirstSet: 11, repsSecondSet: 10)
        squat.recordWorkout("16-05-05", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
        squat.recordWorkout("16-05-07", weight: 145, repsFirstSet: 11, repsSecondSet: 11)
        squat.recordWorkout("16-05-09", weight: 145, repsFirstSet: 12, repsSecondSet: 11)
        squat.recordWorkout("16-05-12", weight: 145, repsFirstSet: 13, repsSecondSet: 11)
        squat.recordWorkout("16-05-14", weight: 155, repsFirstSet: 9, repsSecondSet: 7)
        squat.recordWorkout("16-05-16", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
        squat.recordWorkout("16-05-18", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
        squat.recordWorkout("16-05-20", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
        squat.recordWorkout("16-05-23", weight: 155, repsFirstSet: 10, repsSecondSet: 10)
        squat.recordWorkout("16-05-25", weight: 155, repsFirstSet: 10, repsSecondSet: 10)
        
        let bench = Exercise(name: "Bench Press", notes: "Bench Press notes", workoutDiary: List<Workout>(), goal: 240)
        bench.recordWorkout("16-04-20", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
        bench.recordWorkout("16-04-22", weight: 135, repsFirstSet: 9, repsSecondSet: 7)
        bench.recordWorkout("16-04-25", weight: 135, repsFirstSet: 9, repsSecondSet: 8)
        bench.recordWorkout("16-04-27", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
        bench.recordWorkout("16-04-29", weight: 135, repsFirstSet: 10, repsSecondSet: 8)
        bench.recordWorkout("16-05-02", weight: 135, repsFirstSet: 10, repsSecondSet: 9)
        bench.recordWorkout("16-05-05", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
        bench.recordWorkout("16-05-07", weight: 135, repsFirstSet: 11, repsSecondSet: 9)
        bench.recordWorkout("16-05-09", weight: 135, repsFirstSet: 11, repsSecondSet: 10)
        bench.recordWorkout("16-05-12", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
        bench.recordWorkout("16-05-14", weight: 135, repsFirstSet: 12, repsSecondSet: 10)
        bench.recordWorkout("16-05-16", weight: 135, repsFirstSet: 12, repsSecondSet: 11)
        bench.recordWorkout("16-05-18", weight: 135, repsFirstSet: 13, repsSecondSet: 10)
        bench.recordWorkout("16-05-20", weight: 135, repsFirstSet: 13, repsSecondSet: 11)
        bench.recordWorkout("16-05-23", weight: 145, repsFirstSet: 9, repsSecondSet: 8)
        bench.recordWorkout("16-05-25", weight: 145, repsFirstSet: 9, repsSecondSet: 8)
        
        let row = Exercise(name: "Bent Over Row", notes: "Bent Over Row notes", workoutDiary: List<Workout>(), goal: 240)
        row.recordWorkout("16-04-20", weight: 115, repsFirstSet: 11, repsSecondSet: 10)
        row.recordWorkout("16-04-22", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
        row.recordWorkout("16-04-25", weight: 115, repsFirstSet: 11, repsSecondSet: 11)
        row.recordWorkout("16-04-27", weight: 115, repsFirstSet: 12, repsSecondSet: 10)
        row.recordWorkout("16-04-29", weight: 115, repsFirstSet: 13, repsSecondSet: 10)
        row.recordWorkout("16-05-02", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
        row.recordWorkout("16-05-05", weight: 125, repsFirstSet: 9, repsSecondSet: 8)
        row.recordWorkout("16-05-07", weight: 125, repsFirstSet: 9, repsSecondSet: 9)
        row.recordWorkout("16-05-09", weight: 125, repsFirstSet: 10, repsSecondSet: 9)
        row.recordWorkout("16-05-12", weight: 125, repsFirstSet: 10, repsSecondSet: 10)
        row.recordWorkout("16-05-14", weight: 125, repsFirstSet: 11, repsSecondSet: 10)
        row.recordWorkout("16-05-16", weight: 125, repsFirstSet: 12, repsSecondSet: 10)
        row.recordWorkout("16-05-18", weight: 125, repsFirstSet: 13, repsSecondSet: 11)
        row.recordWorkout("16-05-20", weight: 135, repsFirstSet: 9, repsSecondSet: 8)
        row.recordWorkout("16-05-23", weight: 135, repsFirstSet: 9, repsSecondSet: 9)
        row.recordWorkout("16-05-25", weight: 135, repsFirstSet: 9, repsSecondSet: 9)
        
        let ohp = Exercise(name: "Overhead Press", notes: "OHP notes", workoutDiary: List<Workout>(), goal: 160)
        ohp.recordWorkout("16-04-20", weight: 95, repsFirstSet: 8, repsSecondSet: 8)
        ohp.recordWorkout("16-04-22", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-04-25", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-04-27", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-04-29", weight: 95, repsFirstSet: 10, repsSecondSet: 7)
        ohp.recordWorkout("16-05-02", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-05", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-07", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-09", weight: 95, repsFirstSet: 10, repsSecondSet: 8)
        ohp.recordWorkout("16-05-12", weight: 95, repsFirstSet: 10, repsSecondSet: 9)
        ohp.recordWorkout("16-05-14", weight: 95, repsFirstSet: 10, repsSecondSet: 10)
        ohp.recordWorkout("16-05-16", weight: 95, repsFirstSet: 10, repsSecondSet: 10)
        ohp.recordWorkout("16-05-18", weight: 95, repsFirstSet: 11, repsSecondSet: 8)
        ohp.recordWorkout("16-05-20", weight: 95, repsFirstSet: 11, repsSecondSet: 9)
        ohp.recordWorkout("16-05-23", weight: 95, repsFirstSet: 11, repsSecondSet: 9)
        ohp.recordWorkout("16-05-25", weight: 95, repsFirstSet: 11, repsSecondSet: 9)
        
        let sldl = Exercise(name: "Straight Leg Deadlift", notes: "SLDL notes", workoutDiary: List<Workout>(), goal: 240)
        sldl.recordWorkout("16-04-20", weight: 95, repsFirstSet: 13, repsSecondSet: 11)
        sldl.recordWorkout("16-04-22", weight: 95, repsFirstSet: 13, repsSecondSet: 12)
        sldl.recordWorkout("16-04-25", weight: 105, repsFirstSet: 9, repsSecondSet: 8)
        sldl.recordWorkout("16-04-27", weight: 105, repsFirstSet: 10, repsSecondSet: 10)
        sldl.recordWorkout("16-04-29", weight: 105, repsFirstSet: 11, repsSecondSet: 10)
        sldl.recordWorkout("16-05-02", weight: 105, repsFirstSet: 12, repsSecondSet: 11)
        sldl.recordWorkout("16-05-05", weight: 105, repsFirstSet: 12, repsSecondSet: 11)
        sldl.recordWorkout("16-05-07", weight: 105, repsFirstSet: 13, repsSecondSet: 11)
        sldl.recordWorkout("16-05-09", weight: 115, repsFirstSet: 9, repsSecondSet: 8)
        sldl.recordWorkout("16-05-12", weight: 115, repsFirstSet: 10, repsSecondSet: 9)
        sldl.recordWorkout("16-05-14", weight: 115, repsFirstSet: 11, repsSecondSet: 10)
        sldl.recordWorkout("16-05-16", weight: 115, repsFirstSet: 12, repsSecondSet: 10)
        sldl.recordWorkout("16-05-18", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
        sldl.recordWorkout("16-05-20", weight: 115, repsFirstSet: 13, repsSecondSet: 11)
        sldl.recordWorkout("16-05-23", weight: 125, repsFirstSet: 9, repsSecondSet: 8)
        sldl.recordWorkout("16-05-25", weight: 125, repsFirstSet: 10, repsSecondSet: 9)
        
        let chin = Exercise(name: "Chin-up", notes: "Chin notes", workoutDiary: List<Workout>(), goal: 240)
        chin.recordWorkout("16-04-20", weight: 110, repsFirstSet: 10, repsSecondSet: 9)
        chin.recordWorkout("16-04-22", weight: 110, repsFirstSet: 10, repsSecondSet: 9)
        chin.recordWorkout("16-04-25", weight: 110, repsFirstSet: 10, repsSecondSet: 10)
        chin.recordWorkout("16-04-27", weight: 110, repsFirstSet: 11, repsSecondSet: 10)
        chin.recordWorkout("16-04-29", weight: 110, repsFirstSet: 11, repsSecondSet: 10)
        chin.recordWorkout("16-05-05", weight: 110, repsFirstSet: 11, repsSecondSet: 11)
        chin.recordWorkout("16-05-07", weight: 110, repsFirstSet: 11, repsSecondSet: 11)
        chin.recordWorkout("16-05-09", weight: 110, repsFirstSet: 12, repsSecondSet: 11)
        chin.recordWorkout("16-05-12", weight: 110, repsFirstSet: 13, repsSecondSet: 11)
        chin.recordWorkout("16-05-14", weight: 110, repsFirstSet: 13, repsSecondSet: 11)
        chin.recordWorkout("16-05-16", weight: 120, repsFirstSet: 11, repsSecondSet: 9)
        chin.recordWorkout("16-05-18", weight: 120, repsFirstSet: 11, repsSecondSet: 9)
        chin.recordWorkout("16-05-20", weight: 120, repsFirstSet: 11, repsSecondSet: 10)
        chin.recordWorkout("16-05-23", weight: 120, repsFirstSet: 12, repsSecondSet: 11)
        chin.recordWorkout("16-05-25", weight: 120, repsFirstSet: 12, repsSecondSet: 11)
        
        let calf = Exercise(name: "Calf Raise", notes: "calf notes", workoutDiary: List<Workout>(), goal: 320)
        calf.recordWorkout("16-04-20", weight: 150, repsFirstSet: 13, repsSecondSet: 11)
        calf.recordWorkout("16-04-22", weight: 175, repsFirstSet: 10, repsSecondSet: 8)
        calf.recordWorkout("16-04-25", weight: 175, repsFirstSet: 10, repsSecondSet: 10)
        calf.recordWorkout("16-04-27", weight: 175, repsFirstSet: 11, repsSecondSet: 10)
        calf.recordWorkout("16-04-29", weight: 175, repsFirstSet: 11, repsSecondSet: 11)
        calf.recordWorkout("16-05-05", weight: 175, repsFirstSet: 12, repsSecondSet: 11)
        calf.recordWorkout("16-05-09", weight: 175, repsFirstSet: 12, repsSecondSet: 11)
        calf.recordWorkout("16-05-12", weight: 175, repsFirstSet: 13, repsSecondSet: 11)
        calf.recordWorkout("16-05-16", weight: 195, repsFirstSet: 9, repsSecondSet: 8)
        calf.recordWorkout("16-05-18", weight: 195, repsFirstSet: 10, repsSecondSet: 9)
        calf.recordWorkout("16-05-20", weight: 195, repsFirstSet: 12, repsSecondSet: 11)
        calf.recordWorkout("16-05-23", weight: 195, repsFirstSet: 12, repsSecondSet: 11)
        calf.recordWorkout("16-05-25", weight: 195, repsFirstSet: 13, repsSecondSet: 11)
        
        let torso = Exercise(name: "Torso Rotation", notes: "torso notes", workoutDiary: List<Workout>(), goal: 240)
        torso.recordWorkout("16-04-20", weight: 130, repsFirstSet: 13, repsSecondSet: 11)
        torso.recordWorkout("16-04-22", weight: 140, repsFirstSet: 9, repsSecondSet: 9)
        torso.recordWorkout("16-04-25", weight: 140, repsFirstSet: 11, repsSecondSet: 9)
        torso.recordWorkout("16-04-27", weight: 140, repsFirstSet: 10, repsSecondSet: 10)
        torso.recordWorkout("16-04-29", weight: 140, repsFirstSet: 11, repsSecondSet: 10)
        torso.recordWorkout("16-05-05", weight: 140, repsFirstSet: 11, repsSecondSet: 10)
        torso.recordWorkout("16-05-07", weight: 140, repsFirstSet: 11, repsSecondSet: 11)
        torso.recordWorkout("16-05-09", weight: 140, repsFirstSet: 11, repsSecondSet: 11)
        torso.recordWorkout("16-05-12", weight: 140, repsFirstSet: 12, repsSecondSet: 11)
        torso.recordWorkout("16-05-14", weight: 140, repsFirstSet: 12, repsSecondSet: 11)
        torso.recordWorkout("16-05-16", weight: 140, repsFirstSet: 13, repsSecondSet: 11)
        torso.recordWorkout("16-05-20", weight: 155, repsFirstSet: 9, repsSecondSet: 8)
        torso.recordWorkout("16-05-23", weight: 155, repsFirstSet: 10, repsSecondSet: 9)
        torso.recordWorkout("16-05-25", weight: 155, repsFirstSet: 11, repsSecondSet: 9)
        
        let curl = Exercise(name: "Curl", notes: "curl notes", workoutDiary: List<Workout>(), goal: 120)
        curl.recordWorkout("16-04-20", weight: 50, repsFirstSet: 11, repsSecondSet: 8)
        curl.recordWorkout("16-04-22", weight: 50, repsFirstSet: 11, repsSecondSet: 9)
        curl.recordWorkout("16-04-25", weight: 50, repsFirstSet: 12, repsSecondSet: 10)
        curl.recordWorkout("16-04-27", weight: 50, repsFirstSet: 12, repsSecondSet: 10)
        curl.recordWorkout("16-04-29", weight: 50, repsFirstSet: 12, repsSecondSet: 11)
        curl.recordWorkout("16-05-05", weight: 50, repsFirstSet: 13, repsSecondSet: 11)
        curl.recordWorkout("16-05-07", weight: 60, repsFirstSet: 9, repsSecondSet: 8)
        curl.recordWorkout("16-05-09", weight: 60, repsFirstSet: 9, repsSecondSet: 9)
        curl.recordWorkout("16-05-12", weight: 60, repsFirstSet: 10, repsSecondSet: 9)
        curl.recordWorkout("16-05-14", weight: 60, repsFirstSet: 10, repsSecondSet: 9)
        curl.recordWorkout("16-05-16", weight: 60, repsFirstSet: 11, repsSecondSet: 9)
        curl.recordWorkout("16-05-18", weight: 60, repsFirstSet: 12, repsSecondSet: 9)
        curl.recordWorkout("16-05-20", weight: 60, repsFirstSet: 12, repsSecondSet: 10)
        curl.recordWorkout("16-05-23", weight: 60, repsFirstSet: 12, repsSecondSet: 10)
        curl.recordWorkout("16-05-25", weight: 60, repsFirstSet: 13, repsSecondSet: 11)
        
        exercises = ExerciseProgram(name: "Allpro Auto-regulated", startDate: NSDate(), program: List<Exercise>(), userProfile: User(bodyWeight: 160, name: "Brian"))
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(exercises)
        }
        addExercise(squat)
        addExercise(bench)
        addExercise(row)
        addExercise(ohp)
        addExercise(sldl)
        addExercise(chin)
        addExercise(calf)
        addExercise(torso)
        addExercise(curl)
    }
    
    func getExercise(index: Int) -> Exercise {
        return exercises.program[index]
    }
    
    func removeExercise(index: Int) {
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
    
    func updateExercise(index: Int, updatedExercise: Exercise) {
        let realm = try! Realm()
        try! realm.write {
            exercises.program[index] = updatedExercise
        }
    }
}
