//
//  Helper.swift
//  Workout Tracker
//
//  Created by briancl on 4/28/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation


func calculatePlates(targetWeight: Int) -> String {
    let barWeight = 45
    var plates = [(45, 0), (35, 0), (25, 0), (10, 0), (5,0), (2.5, 0)]
    var tmp = Double(targetWeight - barWeight)
    var bar = "Bar"
    
    for i in 0...plates.count-1 {
        while (tmp / plates[i].0 >= 2) {
            tmp -= (plates[i].0 * 2)
            plates[i].1 += 2
        }
    }
    
    for i in 0...plates.count-1 {
        if plates[i].1 > 0 {
            bar += " + \(plates[i].1)x\(dropTrailingZero(plates[i].0))"
        }
    }
    
    return bar
}

func dropTrailingZero(number: Double) -> String {
    return String(format: "%g", number)
}

func roundToFives(x : Double) -> Int {
    return 5 * Int(round(x / 5.0))
}

func NSDateToPrettyString(date: NSDate) -> String {
    let dateFormatter = NSDateFormatter()
    //dateFormatter.dateFormat = "yy-MM-dd"
    dateFormatter.dateFormat = "MMM d"
    
    return dateFormatter.stringFromDate(date)
}

func calcDaysAgo(daysAgo: Int) -> NSDate {
    let newDateComponents = NSDateComponents()
    newDateComponents.day = -daysAgo
    
    return NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))!
}

func ==(lhs: NSDate, rhs: NSDate) -> Bool
{
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

func <(lhs: NSDate, rhs: NSDate) -> Bool
{
    return lhs.compare(rhs) == .OrderedAscending
}

func >(lhs: NSDate, rhs: NSDate) -> Bool
{
    return lhs.compare(rhs) == .OrderedDescending
}