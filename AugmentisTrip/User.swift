//
//  User.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/7/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit

class User {
    var username: String
    var uid: String
    var fullname: String
    var profileImage: UIImage?
    var email: String
    
    init(uid: String, username: String, profileImage: UIImage, email: String, fullname: String){
        self.uid = uid
        self.username = username
        self.profileImage = profileImage
        self.email = email
        self.fullname = fullname
    }
    
    // save the user information
    func save(completion: @escaping(Error?) -> Void) {
        let ref = DatabaseReference.users(uid: uid).reference()
        ref.setValue(toDictionary())
        if let profileImage = self.profileImage {
            let firbaseImage = FIRImages(image: profileImage)
            firbaseImage.saveProfileImage(uid, { (error) in
                // is called whenever the profile image is successfully upload
                completion(error)
            })
        }
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "uid" : uid,
            "username" : username,
            "fullname" : fullname,
            "email" : email
        ]
    }
}
