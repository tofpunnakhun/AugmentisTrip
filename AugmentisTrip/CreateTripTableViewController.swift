//
//  CreateTripTableViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/12/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import GooglePlaces

class CreateTripTableViewController: UITableViewController{
    
    var memberFromInviteController =  [String]()
    
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDetailTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var timeTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar()
    }
    
    @IBAction func createTripBtnPressed(_ sender: Any) {
        
        if tripNameTextField.text == "" {
            showErrorInputAlert(message: "Event Name")
        } else if tripDetailTextField.text == "" {
            showErrorInputAlert(message: "Event Detail")
        } else if locationButton.currentTitle == "Select Location" {
            showErrorInputAlert(message: "Location")
        } else if startDateTextField.text == "" {
            showErrorInputAlert(message: "Start Date")
        } else if endDateTextField.text == "" {
            showErrorInputAlert(message: "End Date")
        } else if timeTextField.text == "" {
            showErrorInputAlert(message: "Time")
        } else {
            let eventName = tripNameTextField.text!
            let detail = tripDetailTextField.text!
            let location = locationButton.currentTitle!
            let startDate = startDateTextField.text!
            let endDate = endDateTextField.text!
            let time = timeTextField.text!
            
            let event = Event(eventName: eventName, detail: detail, location: location, startDate: startDate, endDate: endDate, time: time)
            let inviteVC = storyboard?.instantiateViewController(withIdentifier: "AddMemberViewController") as! AddMemberViewController
            inviteVC.event = event
            navigationController?.pushViewController(inviteVC, animated: true)
            
//            event.save()
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showErrorInputAlert(message: String) {
        let alert = UIAlertController(title: "Can't Sign up", message: "Please input \(message)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.time
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.timePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func timePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        timeTextField.text = dateFormatter.string(from: sender.date)
    }
    
    
    @IBAction func startDateTextFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.minimumDate = Date()
        datePickerView.addTarget(self, action: #selector(self.startDatePickerValueChanged), for: UIControlEvents.valueChanged)
    }

    func startDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        startDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func endDateTextFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.minimumDate = Date()
        datePickerView.addTarget(self, action: #selector(self.endDatePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func endDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        endDateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func setupToolBar(){
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.tintColor = UIColor.white
        toolBar.barTintColor = UIColor(red: 239/255, green: 147/255, blue: 8/255, alpha: 1.0)
        toolBar.backgroundColor = UIColor(red: 239/255, green: 147/255, blue: 8/255, alpha: 1.0)
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white

        label.textAlignment = NSTextAlignment.center
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        startDateTextField.inputAccessoryView = toolBar
        endDateTextField.inputAccessoryView = toolBar
        timeTextField.inputAccessoryView = toolBar

    }
    
    func donePressed(_ sender: UIBarButtonItem) {
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
        timeTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func locationBtnPressed(_ sender: Any) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
}

extension CreateTripTableViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        locationButton.setTitle(place.name, for: .normal)
        print("Place name: \(place.name)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}
