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

extension Int {
    var roundedToFive: Int {
        return 5 * Int(round(Double(self) / 5.0))
    }
}

extension NSDate {
    var myPrettyString: String {
        let dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "yy-MM-dd"
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.stringFromDate(self)
    }
}

extension Double {
    var trimmedToString: String {
        return String(format: "%g", self)
    }
}