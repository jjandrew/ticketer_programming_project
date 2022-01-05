//
//  EventVenue.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 21/11/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

class EventVenue: NSObject, NSCoding {
    
    //enables event venue to be saved to local storage
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(town, forKey: "town")
        coder.encode(country, forKey: "country")
        coder.encode(postCode, forKey: "postCode")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        town = coder.decodeObject(forKey: "town") as? String ?? ""
        country = coder.decodeObject(forKey: "country") as? String ?? ""
        postCode = coder.decodeObject(forKey: "postCode") as? String ?? ""
    }
    
    let name: String
    let town: String
    let country: String
    let postCode: String
    
    init(name: String, town: String, country: String, postCode: String) {
        self.name = name
        self.town = town
        self.country = country
        self.postCode = postCode
    }
}
