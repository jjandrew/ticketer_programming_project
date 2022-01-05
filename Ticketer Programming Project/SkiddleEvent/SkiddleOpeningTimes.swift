//
//  SkiddleOpeningTimes.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 28/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

struct SkiddleOpeningTimes: Decodable {
    var doorsopen: String
    var doorsclose: String
    var lastentry: String
}
