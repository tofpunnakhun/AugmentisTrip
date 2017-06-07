//
//  FIRImages.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/7/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class FIRImages {
    
    var image: UIImage
    var downloadURL: URL?
    var downloadURLString: String!
    var ref: FIRStorageReference!
    
    init(image: UIImage) {
        self.image = image
    }
    
    func saveProfileImage(_ userUID: String, _ completion: @escaping (Error?) -> Void) {
        let resizeImage = image.resize()
        if let imageData = UIImageJPEGRepresentation(resizeImage, 0.9) {
            // get the reference
            ref = StorageReference.profileImages.reference().child(userUID)
            downloadURLString = ref.description
            
            // save the data to the reference
            ref.put(imageData, metadata: nil, completion: { (metaData, error) in
                completion(error)
            })
        }
    }
}

private extension UIImage {
    func resize() -> UIImage {
        let height: CGFloat = 1000.0
        let ratio = self.size.width / self.size.height
        let width = height * ratio
        
        let newSize = CGSize(width: width, height: height)
        let newRectangle = CGRect(x: 0, y: 0, width: width, height: height)
        
        // context - canvas 
        UIGraphicsBeginImageContext(newSize)
        
        // draw the newly sized image on the canvas
        self.draw(in: newRectangle)
        
        // get the new size image into a new variable
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // close a canvas
        UIGraphicsEndImageContext()
        
        return resizeImage!
    }
}
