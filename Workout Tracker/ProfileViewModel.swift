//
//  ProfileViewModel.swift
//  Workout Tracker
//
//  Created by briancl on 6/29/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct ProfileViewModel {
    
    private let url = "http://fatrice:8080/workouts"
    
    func exportData() {
        
        let realm = try! Realm()
        let exercises = realm.objects(Exercise)
        exercises.map { exercisesJson in
            Alamofire.request(.POST, url, parameters: exercisesJson.toDictionary() as? [String : AnyObject], encoding: .JSON)
        }
        print("exporting \(exercises.count) exercises")
    }
    
    func importData() {
        
        Alamofire.request(.GET, url).responseArray { (response: Response<[Exercise], NSError>) in
            switch response.result {
            case .Success:
                let exercises = response.result.value
                if let exercises = exercises {
                    let realm = try! Realm()
                    print("importing \(exercises.count) exercises")
                    try! realm.write {
                        realm.deleteAll()
                        realm.add(exercises)
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}