//
//  FriendsController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/5/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class FriendsController: UIViewController {
    
    let showLogin = "ShowLogin"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // one time sign in
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil {
                
            } else {
                self.performSegue(withIdentifier: self.showLogin, sender: nil)
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

