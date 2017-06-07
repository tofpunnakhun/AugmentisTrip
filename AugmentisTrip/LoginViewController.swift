//
//  LoginViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/7/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil {
                self.dismiss(animated: false, completion: nil)
            }
        })
    }
}
