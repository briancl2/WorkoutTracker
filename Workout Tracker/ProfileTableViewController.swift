//
//  ProfileTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/13/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON


final class ProfileTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var programTextField: UITextField!
    @IBOutlet weak var bodyweightTextField: UITextField!
    @IBOutlet weak var exportDataButton: UIButton!
    
    // MARK: Public Properties
    
    //var userProfile: User
    let pickOption = ["Allpro", "Allpro self-regulated"]
    
    var newName: String? {
        didSet {
            nameTextField.text = newName
        }
    }
    
    var programName: String? {
        didSet {
            programTextField.text = programName
        }
    }
    
    var bodyweight: Int? {
        didSet {
            bodyweightTextField.text = "\(bodyweight)"
        }
    }
        
    // MARK: View Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        programTextField.inputView = pickerView
        
       // doneButton.enabled = false
        
        nameTextField.delegate = self
        bodyweightTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: PickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        programTextField.text = pickOption[row]
    }
    
    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == programTextField {
            return false
        } else {
            return true
        }
    }
    
    // MARK: Helper Functions
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }

    // MARK: Actions
    
    @IBAction func exportDataButtonTapped(sender: UIButton) {
        
        let realm = try! Realm()
        let exercises = realm.objects(ExerciseProgram).first
        
        //exercises!.exportToCSV()
        
        let dic = exercises!.toDictionary()
        
//        let newjson = JSON(dic)
//        
//        let string = newjson.rawData()
//        print(string)

        
        do {
            if let postData: NSData = try NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions.PrettyPrinted) {
                let json = NSString(data: postData, encoding: NSUTF8StringEncoding)! as String
                print(json)
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
}
