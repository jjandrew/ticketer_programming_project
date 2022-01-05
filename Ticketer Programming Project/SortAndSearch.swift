//
//  SortAndSearch.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 02/11/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation

class SortAndSearch {
    
    let events: [Event] = []
    
    func quickSortByName(array: [Event]) -> [Event] {
        var left = [Event]()
        var right = [Event]()
        var newData = [Event]()
        if array.count < 2 {
            return array
            
        } else {
            let pivot = array[0]
            for i in 1..<array.count {
                let item = array[i]
                if item.eventName < pivot.eventName {
                    left.append(item)
                } else {
                    right.append(item)
                }
            }
            newData.append(contentsOf: (quickSortByName(array: left)))
            newData.append(pivot)
            newData.append(contentsOf: (quickSortByName(array: right)))
            return newData
            
        }
    }
    
    func mergeSortByName(array: [Event]) -> [Event] {
        if array.count > 1 {
            let mid = array.count / 2
            var left: [Event] = []
            var right: [Event] = []
            for i in 0..<mid {
                left.append(array[i])
            }
            for i in mid..<array.count {
                right.append(array[i])
            }
            let leftArray = mergeSortByName(array: left)
            let rightArray = mergeSortByName(array: right)
            return mergeByName(left: leftArray, right: rightArray)
        } else {
            return array
        }
    }

    func mergeByName(left: [Event], right: [Event]) -> [Event] {
        var leftArray = left
        var rightArray = right
        var mergedArray: [Event] = []
        while leftArray.count > 0 && rightArray.count > 0 {
            if leftArray[0].eventName < rightArray[0].eventName {
                mergedArray.append(leftArray[0])
                leftArray.removeFirst()
            } else {
                mergedArray.append(rightArray[0])
                rightArray.removeFirst()
            }
        }
        
        while leftArray.count > 0 {
            mergedArray.append(leftArray[0])
            leftArray.removeFirst()
        }
        
        while rightArray.count > 0 {
            mergedArray.append(rightArray[0])
            rightArray.removeFirst()
        }
        return mergedArray
    }

    func eventLinearSearch(events: [Event], searchEvent: Event) -> (Int?,Bool) {
        if events.count > 0 {
            for i in (0...events.count - 1) {
                if events[i].eventName == searchEvent.eventName {
                    if events[i].date == searchEvent.date {
                        //returns position and whether it was found or not
                        return (i, true)
                    }
                }
            }
        }
        return (nil, false)
    }
    
    func quickSortByDate(array: [Event]) -> [Event] {
        var left = [Event]()
        var right = [Event]()
        var newData = [Event]()
        if array.count < 2 {
            return array
            
        } else {
            let pivot = array[0]
            for i in 1..<array.count {
                let item = array[i]
                if item.dateInt < pivot.dateInt {
                    left.append(item)
                } else {
                    right.append(item)
                }
            }
            newData.append(contentsOf: (quickSortByDate(array: left)))
            newData.append(pivot)
            newData.append(contentsOf: (quickSortByDate(array: right)))
            return newData   
        }
    }
    
    func mergeSortByDate(array: [Event]) -> [Event] {
        if array.count > 1 {
            let mid = array.count / 2
            var left: [Event] = []
            var right: [Event] = []
            for i in 0..<mid {
                left.append(array[i])
            }
            for i in mid..<array.count {
                right.append(array[i])
            }
            let leftArray = mergeSortByName(array: left)
            let rightArray = mergeSortByName(array: right)
            return mergeByDate(left: leftArray, right: rightArray)
        } else {
            return array
        }
    }

    func mergeByDate(left: [Event], right: [Event]) -> [Event] {
        var leftArray = left
        var rightArray = right
        var mergedArray: [Event] = []
        while leftArray.count > 0 && rightArray.count > 0 {
            if leftArray[0].dateInt < rightArray[0].dateInt {
                mergedArray.append(leftArray[0])
                leftArray.removeFirst()
            } else {
                mergedArray.append(rightArray[0])
                rightArray.removeFirst()
            }
        }
        
        while leftArray.count > 0 {
            mergedArray.append(leftArray[0])
            leftArray.removeFirst()
        }
        
        while rightArray.count > 0 {
            mergedArray.append(rightArray[0])
            rightArray.removeFirst()
        }
        return mergedArray
    }
    
    
    func checkEventsAreDifferent(events: [Event]) -> [Event] {
        var i = 0
        var swappedPrevious = false
        var newEventArray: [Event] = []
        
        //sets placeholders for checking events are different
        var name = ""
        var date = ""
        var location: EventVenue? = nil
        var description = ""
        //image = nil
        //demographic = nil
        var websites: [String] = []
        var saved = false

        //checks enough events have been entered
        if events.count == 0 {
            return events
        }
        if events.count == 1 {
            return events
        }
        
        while i != events.count - 1 {
            //if two events in a row have the same name and date
            //must be sorted by name first
            if (events[i].eventName == events[i+1].eventName) && (events[i].date == events[i+1].date) {
                //checks if there is already an event that has been found to be the same
                if swappedPrevious == false {
                    name = events[i].eventName
                    date = events[i].date
                    location = events[i].venue
                    description = events[i].summary
                    //image = events[i].image
                    //demographic = events[i].demographic
                    websites.append(events[i].website[0])
                    swappedPrevious = true
                    if description == "" {
                        description = events[i+1].summary
                    }
                } else {
                    /*
                    if image == nil {
                        image = events[i+1].image
                    }
                    */
                    websites.append(events[i].website[0])
                }
            } else if swappedPrevious == false {
                newEventArray.append(events[i])
            } else {
                //demographic = checkDemographic(event)
                //resets the values and adds the event to the array
                saved = eventLinearSearch(events: profile.savedEvents, searchEvent: events[i]).1
                newEventArray.append(Event(eventName: name, venue: location!, date: date, description: description, saved: saved, website: websites))
                
                name = ""
                date = ""
                location = nil
                description = ""
                //image = nil
                //demographic = nil
                websites = []
                swappedPrevious = false
            }
            i += 1
        }
        //adds the last event to the array
        if name != "" {
            websites.append(events[i].website[0])
            newEventArray.append(Event(eventName: name, venue: location!, date: date, description: description, saved: saved, website: websites))
        } else {
            newEventArray.append(events[i])
        }
        return newEventArray
    }
}



