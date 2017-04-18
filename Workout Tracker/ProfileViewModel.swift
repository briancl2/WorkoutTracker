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
    
    fileprivate let baseurl = "http://fatrice:8080/"
    fileprivate var workoutsUrl: String {
        return baseurl + "workouts/"
    }
    
    fileprivate var profilesUrl: String {
        return baseurl + "profiles/"
    }
    
    let pickOption = ["Allpro", "Allpro self-regulated"]
    
    func exportData() {
        
        let realm = try! Realm()
        let exercises = realm.objects(Exercise.self)
        let user = realm.objects(User.self).first!
        let userWorkoutsUrl = workoutsUrl + user.name
        let userProfilesUrl = profilesUrl + user.name
        
        _ = exercises.map { exercisesJson in
            Alamofire.request(userWorkoutsUrl, method: HTTPMethod.post, parameters: exercisesJson.toDictionary() as? [String : AnyObject], encoding: JSONEncoding.default)
        }
        
        Alamofire.request(userProfilesUrl, method: .post, parameters: user.toDictionary() as? [String : AnyObject], encoding: JSONEncoding.default)
        
        print("exporting \(exercises.count) exercises")
    }
    
    func importData() {
        
        let realm = try! Realm()
        let username = realm.objects(User.self).first?.name ?? "Brian"

        let userWorkoutsUrl = workoutsUrl + username
        let userProfilesUrl = profilesUrl + username
        
        Alamofire.request(userWorkoutsUrl, method: .get).responseArray { (response: DataResponse<[Exercise]>) in
            switch response.result {
            case .success:
                if let exercises = response.result.value {
                    print("importing \(exercises.count) exercises")
                    try! realm.write {
                        realm.delete(realm.objects(Exercise.self))
                        realm.delete(realm.objects(Workout.self))
                        realm.delete(realm.objects(WorkSet.self))
                        for exercise in exercises {
                            let newExercise = Exercise(name: exercise.name, notes: exercise.notes, bodyWeightMultiplier: exercise.bodyWeightMultiplier, workoutDiary: exercise.workoutDiary, username: exercise.username, sortOrder: exercise.sortOrder)
                            realm.add(newExercise)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        Alamofire.request(userProfilesUrl, method: .get).responseArray { (response: DataResponse<[User]>) in
            switch response.result {
            case .success:
                if let user = response.result.value?.first {
                    print("importing \(user.name) user")
                    try! realm.write {
                        realm.delete(realm.objects(User.self))
                        let newUser = User(bodyWeight: user.bodyWeight, name: user.name, age: user.age)
                        realm.add(newUser)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
