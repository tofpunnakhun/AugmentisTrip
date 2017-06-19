//
//  EventCell.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/19/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventNameTextField: UILabel!
    @IBOutlet weak var eventDateTextField: UILabel!
    @IBOutlet weak var eventTimeTextField: UILabel!
    
    var event: Event!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(event: Event) {
        self.eventNameTextField.text = event.eventName
        self.eventDateTextField.text = event.startDate
        self.eventTimeTextField.text = event.time
    }
}
