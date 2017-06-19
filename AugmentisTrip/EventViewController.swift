//
//  EventViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/19/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventTable: UITableView!
    var events = [Event]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTable.delegate = self
        eventTable.dataSource = self
        self.configureDatabase()
    }
    
    func configureDatabase() {
        DatabaseReference.event.reference().observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let eventDict = snap.value as? Dictionary<String, AnyObject> {
                        let event = Event(event: eventDict, key: snap.key)
                        self.events.append(event)
                    }
                }
            }
            self.eventTable.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event = events[indexPath.row]
        
        if let cell = eventTable.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell{
            cell.configureCell(event: event)
            return cell
        } else {
            return EventCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var event: Event!
        
        event = events[indexPath.row]
        
        performSegue(withIdentifier: "showDetail", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            if let detailVC = segue.destination as? EventDetailViewController {
                if let event = sender as? Event {
                    
                    detailVC.eventName = event.eventName
                    detailVC.eventDetail = event.detail
                    detailVC.date = event.startDate
                    detailVC.time = event.time
                    detailVC.key = event.key
                }
            }
        }
    }
}
