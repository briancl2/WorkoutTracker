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
        if let lastWorkout = diary.last {
            diary.append(workout)
            if workout.date < lastWorkout.date { // if the working being added isn't the newest workout
                sortDiaryByDate()
            }
        } else {
            diary = [workout] // adding first workout
        }
    }
    
    func getLastWorkout() -> Workout? {
        return diary.last
    }
    
    func getLastWorkouts(number: Int) -> [Workout]? {
        if diary.count > 0 {
            return Array(diary.suffix(number))
        } else {
            return nil
        }
    }
    
    func sortDiaryByDate() {
        diary.sortInPlace({$0.date < $1.date})
    }

    
    func getOldestWorkoutFromRange(dateRange: Int? = nil) -> Workout? {
        // if diary is empty, return nil
        if diary.count == 0 {
            return nil
        }
        
        // if an argument was passed
        if let dateRange = dateRange {
            let daysAgo = DaysAgo(daysAgo: dateRange).date
            let workoutsInRange = diary.filter({$0.date > daysAgo})
            
            // if there are workouts in the dateRange, return the first one (oldest)
            if workoutsInRange != [] {
                return workoutsInRange.first
            } else {
                return nil // otherwise no workouts were found in range, so return nil
            }
        } else {
            return diary.first // if no argument, just return the first element
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