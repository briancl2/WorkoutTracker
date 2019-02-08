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

//func ==(lhs: Date, rhs: Date) -> Bool
//{
//    return lhs === rhs || lhs.compare(rhs) == .orderedSame
//}

//func <(lhs: Date, rhs: Date) -> Bool
//{
//    return lhs.compare(rhs) == .orderedAscending
//}
//
//func >(lhs: Date, rhs: Date) -> Bool
//{
//    return lhs.compare(rhs) == .orderedDescending
//}

extension Date {
    func daysAgo(_ days: Int) -> Date {
        var newDateComponents = DateComponents()
        newDateComponents.day = -days
        
        return (Calendar.current as NSCalendar).date(byAdding: newDateComponents, to: self, options: NSCalendar.Options.init(rawValue: 0))!
    }
    
    func daysFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
}

extension Date {
    var myPrettyString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yy"
        
        return dateFormatter.string(from: self)
    }
}

extension TimeInterval {
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
        let dictionary = self.dictionaryWithValues(forKeys: properties)
        
        let mutabledic = NSMutableDictionary()
        mutabledic.setValuesForKeys(dictionary)
        
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
                mutabledic.setObject(objects, forKey: prop.name as NSCopying)
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
class ListTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    
    typealias Object = List<T>
    typealias JSON = [[String:Any]]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let result = List<T>()
        if let tempArr = value as? [Any] {
            for entry in tempArr {
                let mapper = Mapper<T>()
                let model : T = mapper.map(JSONObject: entry)!
                result.append(model)
            }
        }
        return result
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        var results = [[String:Any]]()
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
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}
