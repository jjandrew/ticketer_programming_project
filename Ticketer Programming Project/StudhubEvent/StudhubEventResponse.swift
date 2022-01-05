//
//  StudhubEventResponse.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 21/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

struct StudhubEventResponse: Decodable {
    var numFound: Int
    var events: [StudhubEvent]
    
    func convertToEventClass() -> [Event] {
        var events: [Event] = []
        if self.events.count > 0 {
            //for each event returned adds the relvant parts to the event class
            for i in (0 ..< self.events.count) {
                let eventName = self.events[i].name
                let venue = EventVenue(name: self.events[i].venue.name, town: self.events[i].venue.city, country: self.events[i].venue.country, postCode: self.events[i].venue.postalCode)
                let dateStudhub = self.events[i].eventDateUTC
                let dateArrayStudhub = dateStudhub.split(separator: "-")
                let year = dateArrayStudhub[0]
                let month = dateArrayStudhub[1]
                let dayAndTime = dateArrayStudhub[2].split(separator: "T")
                let day = dayAndTime[0]
                let date = "\(day)/\(month)/\(year)"
                let description = self.events[i].description
                let website = "https://www.stubhub.co.uk/\(self.events[i].webURI)"
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
