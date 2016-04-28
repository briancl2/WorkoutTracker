//
//  WorkoutDiary.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class WorkoutDiary: NSObject, NSCoding {
    var diary: [Workout]?
    
    init(diary: [Workout]?) {
        if (diary != nil) {
            self.diary = diary
        } else {
            self.diary = []
        }
    }
    
    struct PropertyKey {
        static let diaryKey = "WorkoutDiary_diary"
    }
    
    func addWorkout(workout: Workout) {
        diary?.append(workout)
    }
    
    func getLastWorkout() -> Workout? {
        return diary?.last
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(diary, forKey: PropertyKey.diaryKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let diary = aDecoder.decodeObjectForKey(PropertyKey.diaryKey) as! [Workout]?
        
        self.init(diary: diary)
    }
    
}