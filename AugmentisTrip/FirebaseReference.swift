//
//  FirebaseReference.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/7/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import Foundation
import Firebase

enum DatabaseReference {
    case root
    case users(uid: String)
    
    // MARK : Public
    
    func reference() -> FIRDatabaseReference {
        switch self {
        case .root:
            return rootRef
        default:
            return rootRef.child(path)
        }
    }
    
    private var rootRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    private var path: String {
        switch self {
        case .root:
            return ""
        case .users(let uid):
            return "users/\(uid)"
        }
    }
}

enum StorageReference {
    case root
    case profileImages
    
    func reference() -> FIRStorageReference {
        switch self {
        case .root:
            return rootRef
        default:
            return rootRef.child(path)
        }
    }
    
    private var rootRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    private var path: String {
        switch self {
        case .root:
            return ""
        case .profileImages:
            return "profileImages"
        }
    }
    
}
