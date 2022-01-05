//
//  Ticketer_Programming_ProjectTests.swift
//  Ticketer Programming ProjectTests
//
//  Created by JJ Andrew on 15/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import XCTest
@testable import Ticketer_Programming_Project
import Firebase

class Ticketer_Programming_ProjectTests: XCTestCase {

    let website: [String] = []
    /*
    func testUrlCreatorReturnsCorrectStringWhenSearchTermIsProvided() {
        let handlingOfSkiddle = HandlingOfSkiddle()
        let search = "vivaldi"
        let result = handlingOfSkiddle.createUrl(term: search)
        let expected = "https://www.skiddle.com/api/v1/events/search/?api_key=52f07458a25911d3e1b89ab9f7f0c448&keyword=vivaldi&order=date&description=1"
        XCTAssertEqual(result, expected)
    }
    
    func testUrlCreatorReturnsNothingWhenNoSearchTermIsProvided() {
        let handlingOfSkiddle = HandlingOfSkiddle()
        let search: String?
        search = nil
        let result = handlingOfSkiddle.createUrl(term: search)
        let expected: String?
        expected = nil
        XCTAssertEqual(result, expected)
    }
     
     
    func testEventChange() {
        let skiddleEvent = SkiddleEventResponse(error: 0, totalcount: "2", pagecount: 2, results: [SkiddleEvent(id: "", EventCode: "", eventname: "Event 1", cancelled: "0", cancellationDate: "", cancellationType: "", cancellationReason: "", rescheduledDate: "", imageurl: "url", largeimageurl: "Url", link: "Event1url", date: "25.11.2020", startdate: "", enddate: "", description: "Event 1 description", minage: "", imgoing: nil, goingtos: 0, goingtocount: "", tickets: true, entryprice: "", eventvisibility: "", artists: [], genres: []), SkiddleEvent(id: "", EventCode: "", eventname: "Event 2", cancelled: "0", cancellationDate: "", cancellationType: "", cancellationReason: "", rescheduledDate: "", imageurl: "url", largeimageurl: "Url", link: "Event2url", date: "26.12.2021", startdate: "", enddate: "", description: "Event 2 description", minage: "", imgoing: nil, goingtos: 0, goingtocount: "", tickets: true, entryprice: "", eventvisibility: "", artists: [], genres: [])])
        let events = skiddleEvent.convertToEventClass()
        XCTAssertEqual(skiddleEvent.results.count, events.count)
        for i in (0...skiddleEvent.results.count-1) {
            XCTAssertEqual(skiddleEvent.results[i].eventname, events[i].eventName)
            XCTAssertEqual(skiddleEvent.results[i].date, events[i].date)
            XCTAssertEqual(skiddleEvent.results[i].description, events[i].description)
            XCTAssertEqual(skiddleEvent.results[i].link, events[i].website[0])
        }
    }
    */
    func testValidateNameWorksForValidValue() {
        let NameEntryViewController = nameEntryViewController()
        let name = "Joe Bloggs"
        let expected = true
        let actual = NameEntryViewController.validateTextEntry(entry: name)
        XCTAssertEqual(expected, actual)
    }
    
    func testValidateNameWorksForEmptyValue() {
        let NameEntryViewController = nameEntryViewController()
        let name: String? =
        nil
        let expected = false
        let actual = NameEntryViewController.validateTextEntry(entry: name)
        XCTAssertEqual(expected, actual)
    }
    
    func testValidateNameWorksForShortValue() {
        let NameEntryViewController = nameEntryViewController()
        let name = "ab"
        let expected = false
        let actual = NameEntryViewController.validateTextEntry(entry: name)
        XCTAssertEqual(expected, actual)
    }
    
    func testValidateNameReturnsFalseForOneName() {
        let NameEntryViewController = nameEntryViewController()
        let name = "abcdefg"
        let expected = false
        let actual = NameEntryViewController.validateTextEntry(entry: name)
        XCTAssertEqual(expected, actual)
    }
    
    func testValidateNameReturnsFalseForFirstNameBeingOneCharacter() {
        let NameEntryViewController = nameEntryViewController()
        let name = "j smith"
        let expected = false
        let actual = NameEntryViewController.validateTextEntry(entry: name)
        XCTAssertEqual(expected, actual)
    }
    /*
    func testQuickSort() {
        let sortAndSearch = SortAndSearch()
        let test1Data: [Event] = [Event(eventName: "event1", venue: nil, date: "", description: "", saved: nil, website: website)]
        let test1Actual = sortAndSearch.quickSortByName(array: test1Data)
        let test1Expected = [Event(eventName: "event1", venue: nil, date: "", description: "", saved: nil, website: website)]
        for event in test1Actual {
            print(event.eventName)
        }
        print("expected1")
        for event in test1Expected {
            print(event.eventName)
        }
        print("")
        
        let test2Data = [Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbb", location: nil, date: "", description: "", saved: nil, website: website), Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: website), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: website)]
        let test2Actual = sortAndSearch.quickSortByName(array: test2Data)
        let test2Expected = [Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: website), Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: website), Event(eventName: "bbb", location: nil, date: "", description: "", saved: nil, website: website)]
        for event in test2Actual {
            print(event.eventName)
        }
        print("expected2")
        for event in test2Expected {
            print(event.eventName)
        }
        print("")
        
        let test3Data = [Event(eventName: "bbc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "aad", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "aaa", location: nil, date: "", description: "", saved: nil, website: [])]
        let test3Actual = sortAndSearch.quickSortByName(array: test3Data)
        let test3Expected = [Event(eventName: "aaa", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "aad", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbc", location: nil, date: "", description: "", saved: nil, website: [])]
        for event in test3Actual {
            print(event.eventName)
        }
        print("expected3")
        for event in test3Expected {
            print(event.eventName)
        }
        print("")
        
        let test4Data = [Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: [])]
        let test4Actual = sortAndSearch.quickSortByName(array: test4Data)
        let test4Expected = [Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "", description: "", saved: nil, website: [])]
        for event in test4Actual {
            print(event.eventName)
        }
        print("expected4")
        for event in test4Expected {
            print(event.eventName)
        }
    }
    
    func testMergeSort() {
        let sortAndSearch = SortAndSearch()
        let test1Data = [Event(eventName: "event1", location: nil, date: "", description: "", saved: nil, website: [])]
        let test1Actual = sortAndSearch.mergeSortByName(array: test1Data)
        let test1Expected = [Event(eventName: "event1", location: nil, date: "", description: "", saved: nil, website: [])]
        for event in test1Actual {
            print(event.eventName)
        }
        print("expected1")
        for event in test1Expected {
            print(event.eventName)
        }
        print("")
        
        let test2Data = [Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbb", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: [])]
        let test2Actual = sortAndSearch.mergeSortByName(array: test2Data)
        let test2Expected = [Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbb", location: nil, date: "", description: "", saved: nil, website: [])]
        for event in test2Actual {
            print(event.eventName)
        }
        print("expected2")
        for event in test2Expected {
            print(event.eventName)
        }
        print("")
        
        let test3Data = [Event(eventName: "bbc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "aad", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "aaa", location: nil, date: "", description: "", saved: nil, website: [])]
        let test3Actual = sortAndSearch.mergeSortByName(array: test3Data)
        let test3Expected = [Event(eventName: "aaa", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "aad", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbc", location: nil, date: "", description: "", saved: nil, website: [])]
        for event in test3Actual {
            print(event.eventName)
        }
        print("expected3")
        for event in test3Expected {
            print(event.eventName)
        }
        print("")
        
        let test4Data = [Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: [])]
        let test4Actual = sortAndSearch.mergeSortByName(array: test4Data)
        let test4Expected = [Event(eventName: "abc", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "", description: "", saved: nil, website: [])]
        for event in test4Actual {
            print(event.eventName)
        }
        print("expected4")
        for event in test4Expected {
            print(event.eventName)
        }
    }
    
    func testNameEntryValidationWorksCorrectly() {
        let NameEntryViewController = nameEntryViewController()
        let entry1 = ""
        let test1Result = NameEntryViewController.validateTextEntry(entry: entry1)
        let expected1 = false
        XCTAssertEqual(test1Result, expected1)
        
        let entry2 = "abcdef"
        let test2Result = NameEntryViewController.validateTextEntry(entry: entry2)
        let expected2 = false
        XCTAssertEqual(test2Result, expected2)
        
        let entry3 = "a defg"
        let test3Result = NameEntryViewController.validateTextEntry(entry: entry3)
        let expected3 = false
        XCTAssertEqual(test3Result, expected3)
        
        let entry4 = "abcd ef"
        let test4Result = NameEntryViewController.validateTextEntry(entry: entry4)
        let expected4 = false
        XCTAssertEqual(test4Result, expected4)
        
        let entry5 = "abcd efgh"
        let test5Result = NameEntryViewController.validateTextEntry(entry: entry5)
        let expected5 = true
        XCTAssertEqual(test5Result, expected5)
        
        let entry6 = "ab cde"
        let test6Result = NameEntryViewController.validateTextEntry(entry: entry6)
        let expected6 = true
        XCTAssertEqual(test6Result, expected6)
    }
    
    func testQuickSortByDate() {
        let sortAndSearch = SortAndSearch()
            let test1Data = [Event(eventName: "event1", location: nil, date: "28/03/2021", description: "", saved: nil, website: [])]
            let test1Actual = sortAndSearch.quickSortByDate(array: test1Data)
            let test1Expected = [Event(eventName: "event1", location: nil, date: "28/03/2021", description: "", saved: nil, website: [])]
            for event in test1Actual {
                print(event.date)
            }
            print("expected1")
            for event in test1Expected {
                print(event.date)
            }
            print("")
            
            let test2Data = [Event(eventName: "bba", location: nil, date: "30/01/2000", description: "", saved: nil, website: []), Event(eventName: "bbb", location: nil, date: "01/03/2001", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "15/11/1990", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "20/04/1995", description: "", saved: nil, website: [])]
            let test2Actual = sortAndSearch.quickSortByDate(array: test2Data)
            let test2Expected = [Event(eventName: "abc", location: nil, date: "15/11/1990", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "20/04/1995", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "30/01/2000", description: "", saved: nil, website: []), Event(eventName: "bbb", location: nil, date: "01/03/2001", description: "", saved: nil, website: [])]
            for event in test2Actual {
                print(event.date)
            }
            print("expected2")
            for event in test2Expected {
                print(event.date)
            }
            print("")
            
        let test3Data = [Event(eventName: "bbf", location: nil, date: "20/01/2022", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "01/05/2020", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "08/02/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "01/01/2020", description: "", saved: nil, website: [])]
            let test3Actual = sortAndSearch.quickSortByDate(array: test3Data)
            let test3Expected = [Event(eventName: "aaa", location: nil, date: "01/01/2020", description: "", saved: nil, website: []), Event(eventName: "aad", location: nil, date: "08/02/2020", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "01/05/2020", description: "", saved: nil, website: []), Event(eventName: "bbc", location: nil, date: "20/01/2022", description: "", saved: nil, website: [])]
            for event in test3Actual {
                print(event.date)
            }
            print("expected3")
            for event in test3Expected {
                print(event.date)
            }
            print("")
            
            let test4Data = [Event(eventName: "bbf", location: nil, date: "05/05/2021", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "16/12/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "15/12/2020", description: "", saved: nil, website: [])]
            let test4Actual = sortAndSearch.quickSortByDate(array: test4Data)
            let test4Expected = [Event(eventName: "abc", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "15/12/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "16/12/2020", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "05/05/2021", description: "", saved: nil, website: [])]
            for event in test4Actual {
                print(event.date)
            }
            print("expected4")
            for event in test4Expected {
                print(event.date)
            }
    }
    
    /*
     
     
    func testEventLinearSearchReturnsFalseOnEmptyArray() {
        let sortAndSearch = SortAndSearch()
        let events: [Event] = []
        let searchEvent = Event(eventName: "Event Search", location: nil, date: "01/01/2000", description: "", saved: nil, website: [])
        XCTAssertFalse(sortAndSearch.eventLinearSearch(events: events, searchEvent: searchEvent))
    }
    
    func testEventLinearSearchReturnFalseWhenEventNotInArray() {
        let sortAndSearch = SortAndSearch()
        let events: [Event] = [
            Event(eventName: "Event1", location: nil, date: "01/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event2", location: nil, date: "02/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event3", location: nil, date: "03/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event4", location: nil, date: "04/01/2000", description: "", saved: nil, website: [])]
        let searchEvent = Event(eventName: "Event Search", location: nil, date: "05/01/2000", description: "", saved: nil, website: [])
        XCTAssertFalse(sortAndSearch.eventLinearSearch(events: events, searchEvent: searchEvent))
    }
    
    func testLinearSearchReturnsFalseWhenNameIsSameButDateIsnt() {
        let sortAndSearch = SortAndSearch()
        let events: [Event] = [
            Event(eventName: "Event1", location: nil, date: "01/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event2", location: nil, date: "02/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event3", location: nil, date: "03/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event4", location: nil, date: "04/01/2000", description: "", saved: nil, website: [])]
        let searchEvent = Event(eventName: "Event4", location: nil, date: "05/01/2000", description: "", saved: nil, website: [])
        XCTAssertFalse(sortAndSearch.eventLinearSearch(events: events, searchEvent: searchEvent))
    }
    
    func testLinearSearchReturnsFalseWhenDateIsSameButNameIsnt() {
        let sortAndSearch = SortAndSearch()
        let events: [Event] = [
            Event(eventName: "Event1", location: nil, date: "01/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event2", location: nil, date: "02/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event3", location: nil, date: "03/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event4", location: nil, date: "04/01/2000", description: "", saved: nil, website: [])]
        let searchEvent = Event(eventName: "Search Event", location: nil, date: "04/01/2000", description: "", saved: nil, website: [])
        XCTAssertFalse(sortAndSearch.eventLinearSearch(events: events, searchEvent: searchEvent))
    }
    
    func testLinearSearchReturnsTrueWhenNameIsInArray() {
        let sortAndSearch = SortAndSearch()
        let events: [Event] = [
            Event(eventName: "Event1", location: nil, date: "01/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event2", location: nil, date: "02/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event3", location: nil, date: "03/01/2000", description: "", saved: nil, website: []),
            Event(eventName: "Event4", location: nil, date: "04/01/2000", description: "", saved: nil, website: [])]
        let searchEvent = Event(eventName: "Event4", location: nil, date: "04/01/2000", description: "", saved: nil, website: [])
        XCTAssertTrue(sortAndSearch.eventLinearSearch(events: events, searchEvent: searchEvent))
    }
 */
    func testmergeSortByDateWorks() {
        let sortAndSearch = SortAndSearch()
        
            let test1Data = [Event(eventName: "event1", location: nil, date: "28/03/2021", description: "", saved: nil, website: [])]
        let test1Actual = sortAndSearch.mergeSortByDate(array: test1Data)
            let test1Expected = [Event(eventName: "event1", location: nil, date: "28/03/2021", description: "", saved: nil, website: [])]
            for event in test1Actual {
                print(event.date)
            }
            print("expected1")
            for event in test1Expected {
                print(event.date)
            }
            print("")
            
            let test2Data = [Event(eventName: "bba", location: nil, date: "30/01/2000", description: "", saved: nil, website: []), Event(eventName: "bbb", location: nil, date: "01/03/2001", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "15/11/1990", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "20/04/1995", description: "", saved: nil, website: [])]
            let test2Actual = sortAndSearch.mergeSortByDate(array: test2Data)
            let test2Expected = [Event(eventName: "abc", location: nil, date: "15/11/1990", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "20/04/1995", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "30/01/2000", description: "", saved: nil, website: []), Event(eventName: "bbb", location: nil, date: "01/03/2001", description: "", saved: nil, website: [])]
            for event in test2Actual {
                print(event.date)
            }
            print("expected2")
            for event in test2Expected {
                print(event.date)
            }
            print("")
            
        let test3Data = [Event(eventName: "bbf", location: nil, date: "20/01/2022", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "01/05/2020", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "08/02/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "01/01/2020", description: "", saved: nil, website: [])]
            let test3Actual = sortAndSearch.mergeSortByDate(array: test3Data)
            let test3Expected = [Event(eventName: "aaa", location: nil, date: "01/01/2020", description: "", saved: nil, website: []), Event(eventName: "aad", location: nil, date: "08/02/2020", description: "", saved: nil, website: []), Event(eventName: "bba", location: nil, date: "01/05/2020", description: "", saved: nil, website: []), Event(eventName: "bbc", location: nil, date: "20/01/2022", description: "", saved: nil, website: [])]
            for event in test3Actual {
                print(event.date)
            }
            print("expected3")
            for event in test3Expected {
                print(event.date)
            }
            print("")
            
            let test4Data = [Event(eventName: "bbf", location: nil, date: "05/05/2021", description: "", saved: nil, website: []), Event(eventName: "abc", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "16/12/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "15/12/2020", description: "", saved: nil, website: [])]
            let test4Actual = sortAndSearch.mergeSortByDate(array: test4Data)
            let test4Expected = [Event(eventName: "abc", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "abd", location: nil, date: "20/06/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "15/12/2020", description: "", saved: nil, website: []), Event(eventName: "bbf", location: nil, date: "16/12/2020", description: "", saved: nil, website: []), Event(eventName: "dfa", location: nil, date: "05/05/2021", description: "", saved: nil, website: [])]
            for event in test4Actual {
                print(event.date)
            }
            print("expected4")
            for event in test4Expected {
                print(event.date)
            }
    }
    */
    
    func testCheckEventsAreEqualForOneEvent() {
        let sortAndSearch = SortAndSearch()
        
        let enteredEvents = [Event(eventName: "testVenue1", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "01/01/2001", description: "description1", saved: false, website: ["www.test.com"])]
        
        let actual = sortAndSearch.checkEventsAreDifferent(events: enteredEvents)
        
        print("""
            Test 1
            \(actual[0].eventName)
            \(actual[0].date)
            \(actual[0].venue.name)
            \(String(describing: actual[0].saved))
            \(actual[0].summary)
            \(actual[0].website)
        """)
    }
    
    func testCheckEventsAreEqualWhen3EventsInARowAreEqualAndTheFirstIsDifferent() {
        let sortAndSearch = SortAndSearch()
        
        let enteredEvents = [Event(eventName: "testVenue1", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "01/01/2001", description: "description1", saved: false, website: ["www.test1.com"]),
            Event(eventName: "testVenue2", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "02/01/2001", description: "description2", saved: false, website: ["www.test2.com"]),
            Event(eventName: "testVenue2", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "02/01/2001", description: "description2", saved: false, website: ["www.test3.com"]),
            Event(eventName: "testVenue2", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "02/01/2001", description: "description2", saved: false, website: ["www.test4.com"])]
        
        let actual = sortAndSearch.checkEventsAreDifferent(events: enteredEvents)
        
        print("Test 2")
        for i in (0...actual.count - 1) {
            print("""
                
            event \(i)
            \(actual[i].eventName)
            \(actual[i].date)
            \(actual[i].venue.name)
            \(String(describing: actual[i].saved))
            \(actual[i].summary)
            \(actual[i].website)
            """)
        }
    }
    
    func testCheckEventsAreEqualWhenAllEventAreDifferent() {
        let sortAndSearch = SortAndSearch()
        
        let enteredEvents = [Event(eventName: "testVenue1", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "01/01/2001", description: "description1", saved: false, website: ["www.test1.com"]),
            Event(eventName: "testVenue2", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "02/01/2001", description: "description2", saved: false, website: ["www.test2.com"]),
            Event(eventName: "testVenue3", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "03/01/2001", description: "description3", saved: false, website: ["www.test3.com"]),
            Event(eventName: "testVenue4", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "04/01/2001", description: "description4", saved: false, website: ["www.test4.com"])]
        
        let actual = sortAndSearch.checkEventsAreDifferent(events: enteredEvents)
        
        print("Test 3")
        for i in (0...actual.count - 1) {
            print("""
                
            event \(i)
            \(actual[i].eventName)
            \(actual[i].date)
            \(actual[i].venue.name)
            \(String(describing: actual[i].saved))
            \(actual[i].summary)
            \(actual[i].website)
            """)
        }
    }
    
    func testCheckEventsAreEqualWhenAllEventAreTheSameAndOnlyOneHasADescription() {
        let sortAndSearch = SortAndSearch()
        
        let enteredEvents = [Event(eventName: "testVenue1", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "01/01/2001", description: "", saved: false, website: ["www.test1.com"]),
            Event(eventName: "testVenue1", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "01/01/2001", description: "description1", saved: false, website: ["www.test2.com"]),
            Event(eventName: "testVenue1", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "01/01/2001", description: "", saved: false, website: ["www.test3.com"]),
            Event(eventName: "testVenue1", venue: EventVenue(name: "venueName", town: "venueTown", country: "venueCounty", postCode: "venuePostcode"), date: "01/01/2001", description: "", saved: false, website: ["www.test4.com"])]
        
        let actual = sortAndSearch.checkEventsAreDifferent(events: enteredEvents)
        
        print("Test 4")
        var i  = 0
        for event in actual {
            print("""
                
            \(i)
            \(event.eventName)
            \(event.date)
            \(event.venue.name)
            \(String(describing: event.saved))
            \(event.summary)
            \(event.website)
            """)
            i += 1
        }
    }
    
    func testCreateIdentifierWorks() {
        let event = Event(eventName: "The Four Seasons Vivaldi", venue: EventVenue(name: "", town: "", country: "", postCode: ""), date: "11/12/2020", description: "", saved: false, website: [])
        event.createIdentifier()
        let expected = "TheFourSeasonsVivaldi20201211"
        XCTAssertEqual(expected, event.identifier)
    }
    
    func testCanAccessDB() {
        print("start")
        let db = Firestore.firestore()
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
