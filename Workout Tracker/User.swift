//
//  User.swift
//  Workout Tracker
//
//  Created by briancl on 5/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    // MARK: Public Properties
    
    dynamic var bodyWeight = 0
    dynamic var name = ""
    
    // MARK: Initializers
    
    convenience init(bodyWeight: Int, name: String) {
        self.init()
        self.bodyWeight = bodyWeight
        self.name = name
    }
}
