//
//  User.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/7/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit

class User {
    private var _position: String
    private var _uid: String
    private var _fullname: String
    private var _profileImage: UIImage?
    private var _email: String
    private var _profileImageURL: String
    
    init(uid: String, position: String, profileImage: UIImage, email: String, fullname: String) {
        self._uid = uid
        self._position = position
        self._profileImage = profileImage
        self._email = email
        self._fullname = fullname
        self._profileImageURL = ""
    }
    
    init(user: Dictionary<String, AnyObject> ) {
        self._uid = user["uid"] as! String
        self._position = user["position"] as! String
        self._profileImageURL = user["profileImageURL"] as! String
        self._email = user["email"] as! String
        self._fullname = user["fullname"] as! String
        self._profileImage = #imageLiteral(resourceName: "icon-defaultAvatar")
    }
    
    var position: String {
        return _position
    }
    
    var uid: String {
        return _uid
    }
    
    var fullname: String {
        return _fullname
    }
    
    var profileImage: UIImage {
        return _profileImage!
    }
    
    var email: String {
        return _email
    }
    
    var profileImageURL: String{
        return _profileImageURL
    }
    
    // save the user information
    func save(completion: @escaping(Error?) -> Void) {
        if let profileImage = self._profileImage {
            let firbaseImage = FIRImages(image: profileImage)
            firbaseImage.saveProfileImage(uid, { (error) in
                self._profileImageURL = firbaseImage.profileImageURL
                let ref = DatabaseReference.users(uid: self.uid).reference()
                ref.setValue(self.toDictionary())
                // is called whenever the profile image is successfully upload
                completion(error)
            })
        }
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "uid" : uid,
            "position" : position,
            "fullname" : fullname,
            "email" : email,
            "profileImageURL" : profileImageURL
        ]
    }
}
