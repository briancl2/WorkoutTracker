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
    
    private let baseurl = "http://fatrice:8080/"
    private var workoutsUrl: String {
        return baseurl + "workouts/"
    }
    
    private var profilesUrl: String {
        return baseurl + "profiles/"
    }
    
    let pickOption = ["Allpro", "Allpro self-regulated"]
    
    func exportData() {
        
        let realm = try! Realm()
        let exercises = realm.objects(Exercise)
        let user = realm.objects(User).first!
        let userWorkoutsUrl = workoutsUrl + user.name
        let userProfilesUrl = profilesUrl + user.name
        
        let test = exercises.map { exercisesJson in
            Alamofire.request(.POST, userWorkoutsUrl, parameters: exercisesJson.toDictionary() as? [String : AnyObject], encoding: .JSON)
        }
        
        Alamofire.request(.POST, userProfilesUrl, parameters: user.toDictionary() as? [String : AnyObject], encoding: .JSON)
        
        print("exporting \(exercises.count) exercises")
    }
    
    func importData() {
        
        let realm = try! Realm()
        let user = realm.objects(User).first!
        
        let userWorkoutsUrl = workoutsUrl + user.name
        let userProfilesUrl = profilesUrl + user.name
        
        Alamofire.request(.GET, userWorkoutsUrl).responseArray { (response: Response<[Exercise], NSError>) in
            switch response.result {
            case .Success:
                if let exercises = response.result.value {
//                    print("importing \(exercises.count) exercises")
//                    try! realm.write {
//                        realm.delete(realm.objects(Exercise))
//                        realm.delete(realm.objects(Workout))
//                        realm.delete(realm.objects(WorkSet))
//                        realm.add(exercises)
//                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        Alamofire.request(.GET, userProfilesUrl).responseArray { (response: Response<[User], NSError>) in
            switch response.result {
            case .Success:
                if let user = response.result.value?.first {
                    print("importing \(user.name) user")
                    try! realm.write {
                        realm.delete(realm.objects(User))
                        realm.add(user)
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}