//
//  Chat.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/20/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class Chat {
    private var _name: String
    private var _message: String
    private var _photoURL: String
    
    init(name: String, message: String, photoURL: String) {
        self._name = name
        self._message = message
        self._photoURL = photoURL
    }
    
    init(chat: Dictionary<String, AnyObject>, key: String ) {
        self._name = chat["name"] as! String
        self._message = chat["message"] as! String
        self._photoURL = chat["photoURL"] as! String
    }
    
    var name: String {
        return _name
    }
    var message: String {
        return _message
    }
    
    var photoURL: String {
        return _photoURL
    }
    
    // save the user information
    func save() {
        let ref = DatabaseReference.event.reference()
        ref.childByAutoId().setValue(self.toDictionary())
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "name" : name,
            "message" : message,
            "photoURL" : photoURL
        ]
    }
}


