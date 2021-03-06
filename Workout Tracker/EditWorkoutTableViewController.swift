//
//  EditWorkoutTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/18/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift

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
    
    private var newDate: NSDate? {
        didSet {
            dateTextField.text = newDate!.myPrettyString
            checkValidExercise()
        }
    }
    
    private var newWeight: Int? {
        didSet {
            weightLabel.text = "\(newWeight!) lbs"
            checkValidExercise()
            self.tableView.reloadData() // update footer BarText
        }
    }
    
    private var newSetOne: Int? {
        didSet {
            setOneLabel.text = "Set 1: \(newSetOne!) reps"
            checkValidExercise()
        }
    }
    
    private var newSetTwo: Int? {
        didSet {
            setTwoLabel.text = "Set 2: \(newSetTwo!) reps"
            checkValidExercise()
        }
    }
    
    private let timerEnd: NSTimeInterval = 90
    private var timerCounter: NSTimeInterval = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit \(exerciseName) Workout"
                
        dateTextField.delegate = self
        doneButton.enabled = false
        
        
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = NSDate()
        datePicker.datePickerMode = UIDatePickerMode.Date
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(RecordWorkoutTableViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        newDate = sender.date
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // disable editing of date text.  datepicker input only
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // MARK: Touch Events
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dateTextField.resignFirstResponder()
        closeKeyboard()
    }
    
    // MARK: Helper Functions
    
    private func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    private func checkValidExercise() {
        if !sameWorkout() && newWeight > 0 {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }
    
    private func sameWorkout() -> Bool {
        if workoutToEdit.date.myPrettyString == newDate?.myPrettyString && workoutToEdit.sets[0].weight == newWeight && workoutToEdit.sets[0].repCount == newSetOne && workoutToEdit.sets[1].repCount == newSetTwo {
            return true
        } else {
            return false
        }
    }
    
    // MARK: Actions
    
    @IBAction func weightStepperChanged(sender: UIStepper) {
        newWeight = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction func setOneStepperChanged(sender: UIStepper) {
        newSetOne = Int(sender.value)
        closeKeyboard()
    }
    
    @IBAction func setTwoStepperChanged(sender: UIStepper) {
        newSetTwo = Int(sender.value)
        closeKeyboard()
    }
    

    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            if let date = newDate, weight = newWeight, setOne = newSetOne, setTwo = newSetTwo {
                let newSets = List<WorkSet>()
                newSets.append(WorkSet(weight: weight, repCount: setOne))
                newSets.append(WorkSet(weight: weight, repCount: setTwo))
                newWorkout = Workout(date: date, sets: newSets)
            }
        }
    }
}


