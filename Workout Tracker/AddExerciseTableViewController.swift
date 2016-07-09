//
//  AddExerciseTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/8/16.
//  Copyright © 2016 briancl. All rights reserved.
//

import UIKit
import RealmSwift

final class AddExerciseTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var notesTextVIew: UITextView!
    
    // MARK: Public Properties
    
    var exercise: Exercise!
    
    let exercisePicker = UIPickerView()
    let exerciseTypes = Array(ExerciseType.cases())
    
    var selectedExercise: ExerciseType? {
        didSet {
            nameTextField.text = selectedExercise!.name
        }
    }


    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //doneButton.enabled = false
        nameTextField.delegate = self
        //goalTextField.delegate = self
        
        exercisePicker.dataSource = self
        exercisePicker.delegate = self
        exercisePicker.showsSelectionIndicator = true
        
    }

    // MARK: UITextFieldDelegate
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        // Hide the keyboard.
//        textField.resignFirstResponder()
//        return true
//    }
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        checkValidExerciseName()
//    }
    
    //  MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //doneButton.enabled = false
        if textField == nameTextField {
            exercisePicker.hidden = false
            textField.inputView = exercisePicker
        }
    }
    
    // MARK: UIPickerView implementation
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exerciseTypes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exerciseTypes[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedExercise = exerciseTypes[row]
        //exercisePicker.hidden = true
    }
    
    // MARK: Helper Functions
    
    private func checkValidExerciseName() {
        // Disable the Done button if the text field is empty.
        let text = nameTextField.text ?? ""
        let goal = Int(goalTextField.text ?? "0")
        doneButton.enabled = !text.isEmpty && goal > 0
    }

    // MARK: Actions
   
    // MARK: - Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            //let name = nameTextField.text ?? ""
            let notes = notesTextVIew.text ?? ""
            //let goal = Int(goalTextField.text ?? "200")!
            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            exercise = Exercise(exerciseType: selectedExercise!, notes: notes)
        }
    }

}
