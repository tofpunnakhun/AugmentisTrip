//
//  Event.swift
//  AugmentisTrip
//
//  Created by Punnakhun on 6/19/2560 BE.
//  Copyright © 2560 Punnakhun. All rights reserved.
//

import UIKit
import Firebase

class Event {
    private var _eventName: String
    private var _detail: String
    private var _location: String
    private var _startDate: String
    private var _endDate: String
    private var _time: String
    private var _key: String
    
    init(eventName: String, detail: String, location: String, startDate: String, endDate: String, time: String) {
        self._eventName = eventName
        self._detail = detail
        self._location = location
        self._startDate = startDate
        self._endDate = endDate
        self._time = time
        self._key = ""
    }
    
    init(event: Dictionary<String, AnyObject>, key: String ) {
        self._eventName = event["eventName"] as! String
        self._location = event["location"] as! String
        self._startDate = event["startDate"] as! String
        self._endDate = event["endDate"] as! String
        self._time = event["time"] as! String
        self._detail = event["detail"] as! String
        self._key = key
    }
    
    var key: String {
        return _key
    }
    var eventName: String {
        return _eventName
    }
    
    var detail: String {
        return _detail
    }
    
    var location: String {
        return _location
    }
    
    var startDate: String {
        return _startDate
    }
    
    var endDate: String {
        return _endDate
    }
    
    var time: String {
        return _time
    }
    
    // save the user information
    func save() {
        let ref = DatabaseReference.event.reference()
        ref.childByAutoId().setValue(self.toDictionary())
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "eventName" : eventName,
            "detail" : detail,
            "location" : location,
            "startDate" : startDate,
            "endDate" : endDate,
            "time" : time
        ]
    }
}

