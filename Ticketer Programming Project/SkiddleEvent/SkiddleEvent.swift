//
//  SkiddleEvent.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 21/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

struct SkiddleEvent: Decodable {
    
    var eventname: String
    var venue: SkiddleVenues
    var imageurl: String
    var largeimageurl: String
    var link: String
    var date: String
    var startdate: String
    var enddate: String
    var description: String
    var openingtimes: SkiddleOpeningTimes

}
    


 
