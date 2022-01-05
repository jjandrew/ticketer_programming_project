//
//  Profile.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 27/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding {
    
    //encodes event so that it can be sotred in local storage
    func encode(with coder: NSCoder) {
        coder.encode(userName, forKey: "userName")
        coder.encode(userBirthdayDate, forKey: "userBirthdayDate")
        coder.encode(userBirthdayString, forKey: "userBirthdayString")
        coder.encode(userGender, forKey: "userGender")
        coder.encode(userLocation, forKey: "userLocation")
        coder.encode(userLongitude, forKey: "userLongitude")
        coder.encode(userLatitude, forKey: "userLatitude")
        coder.encode(userAge, forKey: "userAge")
        coder.encode(savedEvents, forKey: "savedEvents")
        coder.encode(attendingEvents, forKey: "attendingEvents")
        coder.encode(loggedIn, forKey: "loggedIn")
    }
    
    required init?(coder: NSCoder) {
        userName = coder.decodeObject(forKey: "userName") as? String ?? ""
        userBirthdayDate = coder.decodeObject(forKey: "userBirthdayDate") as? Date ?? Date()
        userBirthdayString = coder.decodeObject(forKey: "userBirthdayString") as? String ?? ""
        userGender = coder.decodeObject(forKey: "userGender") as? String ?? ""
        userLocation = coder.decodeObject(forKey: "userLocation") as? String? ?? ""
        userLongitude = coder.decodeObject(forKey: "userLongitude") as? String? ?? ""
        userLatitude = coder.decodeObject(forKey: "userLatitude") as? String? ?? ""
        userAge = coder.decodeObject(forKey: "userAge") as? Int? ?? 0
        savedEvents = coder.decodeObject(forKey: "savedEvents") as? [Event] ?? []
        attendingEvents = coder.decodeObject(forKey: "attendingEvents") as? [Event] ?? []
        loggedIn = coder.decodeObject(forKey: "loggedIn") as? Bool ?? false
    }
    
    override init() {
    }
    
    var userName: String = ""
    var userBirthdayDate = Date()
    var userBirthdayString: String = ""
    var userGender: String = ""
    var userLocation: String? = nil
    var userLongitude: String? = nil
    var userLatitude: String? = nil
    var userAge: Int? = nil
    var savedEvents: [Event] = []
    var attendingEvents: [Event] = []
    var loggedIn: Bool = false
    
}



