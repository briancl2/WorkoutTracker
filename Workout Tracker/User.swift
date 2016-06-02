//
//  User.swift
//  Workout Tracker
//
//  Created by briancl on 5/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift

final class User: Object {
    
    // MARK: Public Properties
    
    dynamic var bodyWeight = 0
    dynamic var name = ""
    dynamic var age = 0
    
    // MARK: Initializers
    
    convenience init(bodyWeight: Int, name: String, age: Int) {
        self.init()
        self.bodyWeight = bodyWeight
        self.name = name
        self.age = age
    }
}
