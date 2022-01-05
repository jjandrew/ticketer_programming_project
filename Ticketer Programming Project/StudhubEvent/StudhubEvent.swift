//
//  StudhubEvent.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 24/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

struct StudhubEvent: Decodable {
    let description: String
    let eventDateUTC: String
    let webURI: String
    let name: String
    let eventDateLocal: String
    let venue: StudhubEventVenue
    
}
