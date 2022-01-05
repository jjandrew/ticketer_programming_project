//
//  SkiddleEventResponse.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 20/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

struct SkiddleEventResponse: Decodable {
    var error: Int
    var totalcount: String = ""
    var pagecount: Int
    var results: [SkiddleEvent]
     
    func convertToEventClass() -> [Event] {
        var events: [Event] = []
        if self.error == 0 && self.results.count > 0 {
            //for each event returned adds the relvant parts to the event class
            for i in (0 ..< self.results.count) {
                let eventName = self.results[i].eventname
                let venue = EventVenue(name: self.results[i].venue.name, town: self.results[i].venue.town, country: self.results[i].venue.country, postCode: self.results[i].venue.postcode)
                let dateSkiddle = self.results[i].date
                let dateArraySkiddle = dateSkiddle.split(separator: "-")
                let year = dateArraySkiddle[0]
                let month = dateArraySkiddle[1]
                let day = dateArraySkiddle[2]
                let date = "\(day)/\(month)/\(year)"
                let description = self.results[i].description
                let website = self.results[i].link
                events.append(Event(eventName: eventName, venue: venue, date: date, description: description, saved: false, website: [website]))
            }
            //adds a date integer to each of the events
            for event in events {
                event.dateIntConversion()
            }
            return events
        } else {
            return []
        }
    }
     
}
