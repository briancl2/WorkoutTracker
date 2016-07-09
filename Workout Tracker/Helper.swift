//
//  Helper.swift
//  Workout Tracker
//
//  Created by briancl on 4/28/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

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
    
    func daysFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
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


// create JSON dictionary
extension Object {
    func toDictionary() -> NSDictionary {
        let properties = self.objectSchema.properties.map { $0.name }
        let dictionary = self.dictionaryWithValuesForKeys(properties)
        
        let mutabledic = NSMutableDictionary()
        mutabledic.setValuesForKeysWithDictionary(dictionary)
        
        for prop in self.objectSchema.properties as [Property]! {
            // find lists
            if let nestedObject = self[prop.name] as? Object {
                mutabledic.setValue(nestedObject.toDictionary(), forKey: prop.name)
            } else if let nestedListObject = self[prop.name] as? ListBase {
                var objects = [AnyObject]()
                for index in 0..<nestedListObject._rlmArray.count  {
                    let object = nestedListObject._rlmArray[index] as AnyObject
                    objects.append(object.toDictionary())
                }
                mutabledic.setObject(objects, forKey: prop.name)
            } else if let dateObject = self[prop.name] as? NSDate {
                //let dateString = dateObject.myPrettyString //Perform NSDate conversion for JSON
                let dateString = dateObject.timeIntervalSince1970
                mutabledic.setValue(dateString, forKey: prop.name)
            }
            
        }
        return mutabledic
    }

}

// add Realm List<> support to ObjectMapper
class ListTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
    typealias Object = List<T>
    typealias JSON = [AnyObject]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        let results = List<T>()
        if let value = value as? [AnyObject] {
            for json in value {
                if let obj = mapper.map(json) {
                    results.append(obj)
                }
            }
        }
        return results
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json)
            }
        }
        return results
    }
}

// Allow enums to be enumerated with cases() function call
protocol EnumCollection : Hashable {}
extension EnumCollection {
    static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyGenerator<S> in
            var raw = 0
            return AnyGenerator {
                let current : Self = withUnsafePointer(&raw) { UnsafePointer($0).memory }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}