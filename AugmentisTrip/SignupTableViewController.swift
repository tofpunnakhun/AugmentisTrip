//
//  SignupTableViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/7/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class SignupTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func changeProfileImageBtnPress(_ sender: Any) {
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion:  nil)
    }
  
    @IBAction func createNewAccountBtnPress(_ sender: Any) {
        
        if !isValidEmail(email: emailTextField.text!) {
            showErrorInputAlert(message: "Email")
        } else if (fullnameTextField.text?.characters.count)! < 4 {
            showErrorInputAlert(message: "Full name")
        } else if (usernameTextField.text?.characters.count)! < 6 {
            showErrorInputAlert(message: "Username")
        } else if (passwordTextField.text?.characters.count)! < 6 {
            showErrorInputAlert(message: "Password")
        } else if profileImageView == nil {
            showErrorInputAlert(message: "Image")
        } else {
            let username = usernameTextField.text!
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let fullname = fullnameTextField.text!
            let profileImage = profileImageView.image!
            
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (firUser, error) in
                
                if error != nil {
                    print(error!)
                
                } else if let firUser = firUser {
                    let newUser = User(uid: firUser.uid, username: username, profileImage: profileImage, email: email, fullname: fullname)
                    newUser.save(completion: { (error) in
                        if error != nil {
                            print(error!)
                        } else {
                           FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (firUser, error) in
                            if let error = error {
                                print(error)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                           })
                        }
                    })
                }
            })
        }
    }
    
    func showErrorInputAlert(message: String) {
        let alert = UIAlertController(title: "Can't Sign up", message: "\(message) invalid", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = selectImage
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
        profileImageView.layer.masksToBounds = true
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func isValidEmail(email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
