//
//  MoreTableViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/8/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class MoreTableViewController: UITableViewController {
    
    @IBOutlet weak var fullnameLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageProfileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = FIRAuth.auth()?.currentUser?.uid
        print (uid!)
        DatabaseReference.users(uid: uid!).reference().observeSingleEvent(of: .value, with: { (snapshot) in
            let user = snapshot.value as? NSDictionary
            let email = user?["email"] as? String
            let fullname = user?["fullname"] as? String
            let position = user?["position"] as? String
            
            
            self.fullnameLabel.text = fullname
            self.emailLabel.text = email
            self.positionLabel.text = position
            
            if let profileImageURL = user?["profileImageURL"] as? String {
                let url = URL(string: profileImageURL)
                let urlRequest = URLRequest(url: url!)
            
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                    // do stuff with response, data & error here
                    if error != nil {
                        print(error!)
                    }
                    DispatchQueue.global(qos: .userInitiated).async {
                        let image = data
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            self.imageProfileImageView.image = UIImage(data: image!)
                        }
                    }
                }).resume()
            }
        })
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
      try!  FIRAuth.auth()?.signOut()
        
      self.dismiss(animated: true, completion: nil)
    }
}
