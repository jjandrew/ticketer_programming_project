//
//  Event.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 20/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation
import UIKit

class Event: NSObject, NSCoding {
    
    //codes event for saving to local storage
    func encode(with coder: NSCoder) {
        coder.encode(eventName, forKey: "eventName")
        coder.encode(venue, forKey: "venue")
        coder.encode(date, forKey: "date")
        coder.encode(dateInt, forKey: "dateInt")
        coder.encode(summary, forKey: "summary")
        coder.encode(saved, forKey: "saved")
        coder.encode(website, forKey: "website")
    }
    
    required init?(coder: NSCoder) {
        eventName = coder.decodeObject(forKey: "eventName") as? String ?? ""
        venue = coder.decodeObject(forKey: "venue") as! EventVenue
        date = coder.decodeObject(forKey: "date") as? String ?? ""
        dateInt = coder.decodeObject(forKey: "dateInt") as? Int ?? 0
        summary = coder.decodeObject(forKey: "summary") as? String ?? ""
        saved = coder.decodeObject(forKey: "saved") as? Bool ?? false
        website = coder.decodeObject(forKey: "website") as? [String] ?? []
    }
    
    let eventName : String
    let venue: EventVenue
    let date: String
    var dateInt: Int
    var summary: String
    var saved: Bool
    var website: [String]
    var identifier = ""
    var demographic: Demographic? = nil
    
    init(eventName: String, venue: EventVenue, date: String, description: String, saved: Bool, website: [String]) {
        self.eventName = eventName
        self.venue = venue
        self.date = date
        self.summary = description
        self.saved = saved
        self.website = website
        self.dateInt = 0
    }
    
    func dateIntConversion() {
        let dateArray = self.date.split(separator: "/")
        self.dateInt = Int(dateArray[2]+dateArray[1]+dateArray[0])!
    }
    
    func createIdentifier() {
        identifier = ""
        self.dateIntConversion()
        //splits array around space in name
        let nameArray = self.eventName.split(separator: " ")
        for name in nameArray {
            identifier += name
        }
        //removes any / from string which would cause an error in firestore
        let tempIdentifier = identifier
        identifier = ""
        let secondNameArray = tempIdentifier.split(separator: "/")
        for name in secondNameArray {
            identifier += name
        }
        identifier += String(self.dateInt)
    }
}
