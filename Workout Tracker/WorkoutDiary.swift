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
        // if diary is empty, return nil
        if diary.count == 0 {
            return nil
        }
        
        // if an argument was passed
        if let dateRange = dateRange {
            let daysAgo = calcDaysAgo(dateRange)
            
            // iterate through Diary in reverse to find first workout that is older than dateRange
            for workout in diary.reverse() {
                
                // find the first workout that is older than our dateRange
                if workout.date < daysAgo {
                    
                    // if that workout happens to be our last workout, return nil
                    if workout == diary.last {
                        return nil
                    }
                    
                    // otherwise, return the workout just ahead of the matched workout
                    return diary[diary.indexOf(workout)!+1]
                }
            }
            
            // if we don't find any workouts that are older than our range, return the first
            return diary.first
        } else {
            
            // if no argument, just return the first element
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