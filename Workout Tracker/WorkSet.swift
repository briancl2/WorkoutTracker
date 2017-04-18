//
//  WorkSet.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

final class WorkSet: Object, Mappable {
    
    // MARK: Public Properties
    
    fileprivate(set) dynamic var weight = 0
    fileprivate(set) dynamic var repCount = 0
    var volume: Int {
        return weight * repCount
    }
    
    // MARK: Initializers
    
    convenience init(weight: Int, repCount: Int) {
        self.init()
        self.weight = weight
        self.repCount = repCount
    }
    
    // required by ObjectMapper
    required convenience init?(map: Map) {
        self.init()
    }
    
}

// Support for ObjectMapper
extension WorkSet {
    
    func mapping(map: Map) {
        weight <- map["weight"]
        repCount <- map["repCount"]
    }
    
}
