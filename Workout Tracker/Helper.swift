//
//  Helper.swift
//  Workout Tracker
//
//  Created by briancl on 4/28/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation




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

extension NSDate {
    func daysAgo(days: Int) -> NSDate {
        let newDateComponents = NSDateComponents()
        newDateComponents.day = -days
        
        return NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: self, options: NSCalendarOptions.init(rawValue: 0))!
    }
}

extension NSDate {
    var myPrettyString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.stringFromDate(self)
    }
}

extension NSTimeInterval {
    var myPrettyString: String {
        let minutes = Int(self) / 60
        let seconds = self - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%02i",minutes,Int(seconds),Int(secondsFraction * 100.0))
    }
}

extension Int {
    var roundedToFive: Int {
        return 5 * Int(round(Double(self) / 5.0))
    }
}

extension Double {
    var trimmedToString: String {
        return String(format: "%g", self)
    }
}


