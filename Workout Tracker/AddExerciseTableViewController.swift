//
//  AddExerciseTableViewController.swift
//  Workout Tracker
//
//  Created by briancl on 5/8/16.
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


final class AddExerciseTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var notesTextVIew: UITextView!
    
    // MARK: Public Properties
    
    fileprivate let addExerciseViewModel = AddExerciseViewModel()
    
    var exercise: Exercise!
    
    fileprivate let exercisePicker = UIPickerView()
    
    fileprivate var selectedExercise: ExerciseType? {
        didSet {
            nameTextField.text = selectedExercise!.name
        }
    }


    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        nameTextField.delegate = self
        goalTextField.delegate = self
        
        exercisePicker.dataSource = self
        exercisePicker.delegate = self
        exercisePicker.showsSelectionIndicator = true
        
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        doneButton.isEnabled = false
        if textField == nameTextField {
            exercisePicker.isHidden = false
            textField.inputView = exercisePicker
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidExerciseName()
    }
    
    // disable editing of name text.  picker input only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            return false
        } else {
            return true
        }
    }
    
    // MARK: UIPickerView implementation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addExerciseViewModel.exerciseTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addExerciseViewModel.exerciseTypes[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedExercise = addExerciseViewModel.exerciseTypes[row]
        //exercisePicker.hidden = true
    }
    
    // MARK: Helper Functions
    
    fileprivate func checkValidExerciseName() {
        // Disable the Done button if the text field is empty.
        let text = nameTextField.text ?? ""
        let goal = Int(goalTextField.text ?? "0")
        doneButton.isEnabled = !text.isEmpty && goal > 0
    }

    // MARK: Actions
   
    // MARK: - Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if doneButton === sender as AnyObject? {
            //let name = nameTextField.text ?? ""
            let notes = notesTextVIew.text ?? ""
            //let goal = Int(goalTextField.text ?? "200")!
            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            exercise = Exercise(exerciseType: selectedExercise!, notes: notes)
        }
    }

}
