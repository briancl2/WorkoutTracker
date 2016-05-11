//
//  DaysAgo.swift
//  Workout Tracker
//
//  Created by briancl on 5/11/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation

struct DaysAgo {
    var date = NSDate()
    
    init(daysAgo: Int) {
        self.date = calcDaysAgo(daysAgo)
    }
    
    private func calcDaysAgo(daysAgo: Int) -> NSDate {
        let newDateComponents = NSDateComponents()
        newDateComponents.day = -daysAgo
        
        return NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))!
    }
}