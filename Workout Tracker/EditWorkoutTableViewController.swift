//
//  EditWorkoutTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/18/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


final class EditWorkoutTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var setOneLabel: UILabel!
    @IBOutlet weak var setTwoLabel: UILabel!
    @IBOutlet weak var weightStepper: UIStepper!
    @IBOutlet weak var setOneStepper: UIStepper!
    @IBOutlet weak var setTwoStepper: UIStepper!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: Public Properties
    
    var newWorkout: Workout! // the new Workout to construct here and pass back to the unwind of the sender
    var workoutToEdit: Workout! // passed from sender
    var exerciseName: String! // passed from sender
    
    fileprivate var newDate: Date? {
        didSet {
            dateTextField.text = newDate!.myPrettyString
            checkValidExercise()
        }
    }
    
    fileprivate var newWeight: Int? {
        didSet {
            weightLabel.text = "\(newWeight!) lbs"
            checkValidExercise()
            self.tableView.reloadData() // update footer BarText
        }
    }
    
    fileprivate var newSetOne: Int? {
        didSet {
            setOneLabel.text = "Set 1: \(newSetOne!) reps"
            checkValidExercise()
        }
    }
    
    fileprivate var newSetTwo: Int? {
        didSet {
            setTwoLabel.text = "Set 2: \(newSetTwo!) reps"
            checkValidExercise()
        }
    }
    
    fileprivate let timerEnd: TimeInterval = 90
    fileprivate var timerCounter: TimeInterval = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit \(exerciseName) Workout"
                
        dateTextField.delegate = self
        doneButton.isEnabled = false
        
        
        newDate = workoutToEdit.date
        newWeight = workoutToEdit.weight
        newSetOne = workoutToEdit.sets[0].repCount
        newSetTwo = workoutToEdit.sets[1].repCount

        
        weightStepper.stepValue = 5
        weightStepper.maximumValue = 995
        weightStepper.value = Double(newWeight!)
        
        setOneStepper.stepValue = 1
        setOneStepper.minimumValue = 1
        setOneStepper.maximumValue = 20
        setOneStepper.value = Double(newSetOne!)
        
        setTwoStepper.stepValue = 1
        setTwoStepper.minimumValue = 1
        setTwoStepper.maximumValue = 20
        setTwoStepper.value = Double(newSetTwo!)
        
    }
    

    //  MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(RecordWorkoutTableViewController.datePickerChanged(_:)), for: .valueChanged)
    }
    
    func datePickerChanged(_ sender: UIDatePicker) {
        newDate = sender.date
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // disable editing of date text.  datepicker input only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // MARK: Touch Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dateTextField.resignFirstResponder()
        closeKeyboard()
    }
    
    // MARK: Helper Functions
    
    fileprivate func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    fileprivate func checkValidExercise() {
        if !sameWorkout() && newWeight > 0 {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
    
    fileprivate func sameWorkout() -> Bool {
        if workoutToEdit.date.myPrettyString == newDate?.myPrettyString && workoutToEdit.sets[0].weight == newWeight && workoutToEdit.sets[0].repCount == newSetOne && workoutToEdit.sets[1].repCount == newSetTwo {
            return true
        } else {
            return false
        }
    }
    
    // MARK: Actions
    
    @IBAction func weightStepperChanged(_ sender: UIStepper) {
        newWeight = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction func setOneStepperChanged(_ sender: UIStepper) {
        newSetOne = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction func setTwoStepperChanged(_ sender: UIStepper) {
        newSetTwo = Int(sender.value)
        closeKeyboard()
    }
    

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if doneButton === sender as AnyObject? {
            if let date = newDate, let weight = newWeight, let setOne = newSetOne, let setTwo = newSetTwo {
                let newSets = List<WorkSet>()
                newSets.append(WorkSet(weight: weight, repCount: setOne))
                newSets.append(WorkSet(weight: weight, repCount: setTwo))
                newWorkout = Workout(date: date, sets: newSets)
            }
        }
    }
}


