//
//  ExerciseProgram.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class ExerciseProgram: NSObject, NSCoding {
    
    // MARK: Public Properties
    
    var name: String
    var startDate: NSDate
    var userProfile: User
    var program: [Exercise]
    var count: Int {
        return program.count
    }
    
    // MARK: Initializers

    init(name: String, startDate: NSDate, program: [Exercise], userProfile: User) {
        self.name = name
        self.startDate = startDate
        self.program = program
        self.userProfile = userProfile
    }
    
    convenience override init() {
        self.init(name: "AllPro", startDate: NSDate(), program: [], userProfile: User())
    }
   
    // MARK: Public Methods
    
    func addExercise(newExercise: Exercise) {
        program.append(newExercise)
    }
    
    func getExercise(index: Int) -> Exercise {
        return program[index]
    }
    
    func updateExercise(index: Int, updatedExercise: Exercise) {
        program[index] = updatedExercise
    }
    
    func removeExercise(index: Int) {
        program.removeAtIndex(index)
    }
    
    // MARK: Persistence Methods
    
    func saveProgram() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(self), forKey: "ExerciseProgram")
        defaults.synchronize()
    }
    
    func loadProgram() -> ExerciseProgram? {
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let decodedNSData = defaults.objectForKey("ExerciseProgram") as? NSData,
            let exerciseProgram = NSKeyedUnarchiver.unarchiveObjectWithData(decodedNSData) as? ExerciseProgram
            else {
                print("Failed")
                return nil
        }
        return exerciseProgram
    }
    
    // MARK: Persistence: NSCoder
    
    private struct PropertyKey {
        static let nameKey = "ExerciseProgram_name"
        static let startDateKey = "ExerciseProgram_startDate"
        static let programKey = "ExerciseProgram_program"
        static let userProfile = "ExerciseProgram_userProfile"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(startDate, forKey: PropertyKey.startDateKey)
        aCoder.encodeObject(program, forKey: PropertyKey.programKey)
        aCoder.encodeObject(userProfile, forKey: PropertyKey.userProfile)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let startDate = aDecoder.decodeObjectForKey(PropertyKey.startDateKey) as! NSDate
        let program = aDecoder.decodeObjectForKey(PropertyKey.programKey) as! [Exercise]
        let userProfile = aDecoder.decodeObjectForKey(PropertyKey.userProfile) as! User
        
        // Must call designated initializer.
        self.init(name: name, startDate: startDate, program: program, userProfile: userProfile)
    }
}