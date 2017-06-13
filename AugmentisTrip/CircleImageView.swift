//
//  CircleImageView.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/11/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        layer.masksToBounds = true
    }
}
