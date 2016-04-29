//
//  WorkoutDiary.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

class WorkoutDiary: NSObject, NSCoding {
    var diary: [Workout] = []
    
    init(diary: [Workout]) {
        self.diary = diary
    }
    
    struct PropertyKey {
        static let diaryKey = "WorkoutDiary_diary"
    }
    
    func addWorkout(workout: Workout) {
        diary.append(workout)
    }
    
    func getLastWorkout() -> Workout? {
        return diary.last
    }
    
    func getOldestWorkoutFromRange(dateRange: Int? = nil) -> Workout? {
        if diary.count == 0 {
            return nil
        }
        
        if let dateRange = dateRange {
            let daysAgo = calcDaysAgo(dateRange)
            var index = diary.count
            
            // iterate through Diary in reverse and find first Workout that is older than dateRange-ago
            for workout in diary.reverse() {
                print(workout.date)
                print(index)
                index -= 1
                if workout.date < daysAgo {
                    return diary[index+1]
                }
            }

            return diary.first
            
        } else {
            return diary.first
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(diary, forKey: PropertyKey.diaryKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let diary = aDecoder.decodeObjectForKey(PropertyKey.diaryKey) as! [Workout]
        
        self.init(diary: diary)
    }
    
}