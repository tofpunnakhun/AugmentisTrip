//
//  AddMemberViewController.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/19/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase


class AddMemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var eventTableView: UITableView!
    
    var event: Event?
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        self.configureDatabase()
    }
    
    func configureDatabase() {
        DatabaseReference.allUser.reference().observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let user = User(user: userDict)
                        self.users.append(user)
                    }
                }
            }
            self.eventTableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        
        if let cell = eventTableView.dequeueReusableCell(withIdentifier: "MemberCell") as? MemberCell{
            cell.configureCell(user: user)
            return cell
        } else {
            return MemberCell()
        }
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        event?.save()
        dismiss(animated: true, completion: nil)
    }

}
