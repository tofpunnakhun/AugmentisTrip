//
//  LoginTableViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/7/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class LoginTableViewController: UITableViewController {

 
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (firUser, error) in
                if let error = error {
                    print(error)
                    self.showErrorInputAlert(message: error.localizedDescription)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            showErrorInputAlert(message: "Username and Password can not be empty")
        }
    }
    
    func showErrorInputAlert(message: String) {
        let alert = UIAlertController(title: "Can't Login", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
