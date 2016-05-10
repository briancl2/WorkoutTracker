//
//  RecordWorkoutTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/6/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit

class RecordWorkoutTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var setOneLabel: UILabel!
    @IBOutlet weak var setTwoLabel: UILabel!
    @IBOutlet weak var weightStepper: UIStepper!
    @IBOutlet weak var setOneStepper: UIStepper!
    @IBOutlet weak var setTwoStepper: UIStepper!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    var newWorkout: Workout?
    
    var newDate: NSDate? {
        didSet {
            dateTextField.text = NSDateToPrettyString(newDate!)
        }
    }
    var newWeight: Int? {
        didSet {
            weightLabel.text = "\(newWeight!) lbs"
            checkValidExercise()
        }
    }
    
    var newSetOne: Int? {
        didSet {
            setOneLabel.text = "Set 1: \(newSetOne!) reps"
        }
    }
    
    var newSetTwo: Int? {
        didSet {
            setTwoLabel.text = "Set 2: \(newSetTwo!) reps"
        }
    }

    var workout: Workout?

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
    
    // MARK: Helper Functions
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func checkValidExercise() {
        if newWeight > 0 {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }
    
    // MARK: Touch Events

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dateTextField.resignFirstResponder()
        closeKeyboard()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        doneButton.enabled = false
        
        newDate = NSDate()

        if let lastWorkout = workout {
            newWeight = lastWorkout.sets[0].weight
            newSetOne = lastWorkout.sets[0].repCount
            newSetTwo = lastWorkout.sets[1].repCount
        } else {
            newWeight = 0
            newSetOne = 9
            newSetTwo = 8
        }
        
        weightStepper.stepValue = 5
        weightStepper.maximumValue = 995
        weightStepper.value = Double(newWeight!)
        
        setOneStepper.stepValue = 1
        setOneStepper.maximumValue = 20
        setOneStepper.value = Double(newSetOne!)
        
        setTwoStepper.stepValue = 1
        setTwoStepper.maximumValue = 20
        setTwoStepper.value = Double(newSetTwo!)

    }

    // MARK: Actions
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
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
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            let newSets = [Sets(weight: newWeight!, repCount: newSetOne!), Sets(weight: newWeight!, repCount: newSetTwo!)]

            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            newWorkout = Workout(date: newDate!, sets: newSets)
        }
    }



}
