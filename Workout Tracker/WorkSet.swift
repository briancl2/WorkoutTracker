//
//  WorkSet.swift
//  Workout Tracker
//
//  Created by briancl on 4/27/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

final class WorkSet: Object {
    
    // MARK: Public Properties
    
    dynamic var weight = 0
    dynamic var repCount = 0
    var volume: Int {
        return weight * repCount
    }
    
    // MARK: Initializers
    
    convenience init(weight: Int, repCount: Int) {
        self.init()
        self.weight = weight
        self.repCount = repCount
    }
}
