//
//  EventDetailViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/19/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase
import MobileCoreServices


class EventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDetailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var eventName: String = ""
    var eventDetail: String = ""
    var date: String = ""
    var time: String = ""
    var key: String = ""
    var event: Event!
    
    private var message = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("Key = \(key)")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        eventNameLabel.text = eventName
        eventDetailLabel.text = eventDetail
        dateLabel.text = date
        timeLabel.text = time
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        
        return cell
    }
}
