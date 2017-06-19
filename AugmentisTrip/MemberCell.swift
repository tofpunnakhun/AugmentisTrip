//
//  MemberCell.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/19/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {

    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: CircleImageView!
    
    var user: User!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkboxButton.setBackgroundImage(UIImage(named: "box"), for: .normal)
        checkboxButton.setBackgroundImage(UIImage(named: "checkBox"), for: .selected)
    }
    
    func configureCell(user: User) {
        configureImage(profileImageUrl: user.profileImageURL)
        self.nameLabel.text = user.fullname
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
                    self.profileImage.image = UIImage(data: image!)
                }
            }
        }).resume()
    }
    
    @IBAction func checkboxPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
