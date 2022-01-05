//
//  StudhubEventVenue.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 27/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

struct StudhubEventVenue: Decodable {
    let city: String
    let name: String
    let longitude: Float
    let latitude: Float
    let postalCode: String
    let country:String
}

