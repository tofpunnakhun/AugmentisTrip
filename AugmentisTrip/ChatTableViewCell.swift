//
//  ChatTableViewCell.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/20/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    var chat: Chat!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: CircleImageView!
    
    func configureCell(chat: Chat) {
        configureImage(profileImageUrl: chat.photoURL)
        self.nameLabel.text = chat.name
        self.messageLabel.text = chat.message
        
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

}
