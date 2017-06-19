//
//  FriendCell.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/11/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit

class StaffCell: UITableViewCell {

    @IBOutlet weak var profileImageView: CircleImageView!
    @IBOutlet weak var staffNameLabel: UILabel!
    @IBOutlet weak var staffEmailLabel: UILabel!
    
    var user: User!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(user: User) {
        configureImage(profileImageUrl: user.profileImageURL)
        self.staffNameLabel.text = user.fullname
        self.staffEmailLabel.text = user.email
        
    }
    
    private func configureImage(profileImageUrl : String){
        let url = URL(string: profileImageUrl)
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
                    self.profileImageView.image = UIImage(data: image!)
                }
            }
        }).resume()
    }
}
