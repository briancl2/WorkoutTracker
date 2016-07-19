//
//  User.swift
//  Workout Tracker
//
//  Created by briancl on 5/1/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

final class User: Object, Mappable {
    
    // MARK: Public Properties
    
    private(set) dynamic var bodyWeight = 0
    private(set) dynamic var name = ""
    private(set) dynamic var age = 0
    
    // MARK: Initializers
    
    convenience init(bodyWeight: Int, name: String, age: Int) {
        self.init()
        self.bodyWeight = bodyWeight
        self.name = name
        self.age = age
    }
    
    // required for ObjectMapper
    required convenience init?(_ map: Map) {
        self.init()
    }
    
}

// Support for ObjectMapper
extension User {
    
    func mapping(map: Map) {
        bodyWeight <- map["bodyWeight"]
        name <- map["name"]
        age <- map["age"]
    }
    
}
