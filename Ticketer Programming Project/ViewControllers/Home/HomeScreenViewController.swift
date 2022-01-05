//
//  HomeScreenViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 15/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var nameTextEntry: UITextField!
    @IBOutlet var currentLocationLabel: UILabel!
    @IBOutlet var searchByLocationButton: UIButton!
    @IBOutlet var eventsYouAreInterestedInLabel: UILabel!
    @IBOutlet var interestedEventsMore: UIButton!
    @IBOutlet var leftHandInterestedEvent: UILabel!
    @IBOutlet var rightHandInterestedEvent: UILabel!
    @IBOutlet var previousInterestedEvent: UIButton!
    @IBOutlet var nextInterestedEvent: UIButton!
    @IBOutlet var suggestedEventsLabel: UILabel!
    @IBOutlet var suggestedEventsMore: UIButton!
    @IBOutlet var leftHandAttendingEvent: UILabel!
    @IBOutlet var rightHandAttendingEvent: UILabel!
    @IBOutlet var previousAttendingEvent: UIButton!
    @IBOutlet var nextAttendingEvent: UIButton!
    @IBOutlet var singleEventInterestedLabel: UILabel!
    @IBOutlet var singleEventAttendingLabel: UILabel!
    
    
    var searchEntry: String = ""
    var events: [Event] = []
    
    var savedIndex = 0
    var attendingIndex = 0
    
    let locationManager = CLLocationManager()
    let locationManagerDelegate = LocationManagerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkEventDates()
        //loads event to home screen
        savedIndex = 0
        attendingIndex = 0
        displaySavedEvents(index: savedIndex)
        displayAttendingEvents(index: attendingIndex)
        
        //requests and displays location
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = locationManagerDelegate
        locationManagerDelegate.vc = self
        locationManager.requestLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let savedEvents = defaults.object(forKey: "savedEvents") {
            let events = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedEvents as! Data) as! [Event]
            profile.savedEvents = events
        }
        if let attendingEvents = defaults.object(forKey: "attendingEvents") {
            let events = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(attendingEvents as! Data) as! [Event]
            profile.attendingEvents = events
        }
        //resets events on home screen
        savedIndex = 0
        attendingIndex = 0
        displaySavedEvents(index: savedIndex)
        displayAttendingEvents(index: attendingIndex)
    }
    
    func searchByName(completion: @escaping ([Event]) -> Void) {
        //searches for events using Studhub API
        let handlingOfStudhub = HandlingOfStudhub()
        self.events = []
        var completions = 0
        let urlStudhub = handlingOfStudhub.createUrlForName(term: self.searchEntry)!
        handlingOfStudhub.createJsonString(urlEntry: urlStudhub) { finalEvents in
            self.events += finalEvents
            completions += 1
            //searchs for events using Skiddle API
            let handlingOfSkiddle = HandlingOfSkiddle()
            let urlSkiddle = handlingOfSkiddle.createUrlForName(term: self.searchEntry)!
            handlingOfSkiddle.createJsonString(urlEntry: urlSkiddle) { finalEvents in
               self.events += finalEvents
               completions += 1
                //completes completion handler
                completion(self.events)
           }
        }  
    }
    
    @IBAction func searchByNameButton(_ sender: Any) {
        //performs validation on text entry
        if let searchEntry = nameTextEntry.text {
            if searchEntry.count > 2 {
                self.searchEntry = searchEntry
                view.endEditing(true)
                var events: [Event] = []
                //syncs completions onto main queue
                DispatchQueue.main.async {
                    self.searchByName() { finalEvents in
                        DispatchQueue.main.async {
                            //opens table vc
                            events = self.events
                            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "searchTableView") as? SearchViewController else {
                                fatalError("Could not load view controller from storyboard")
                            }
                            viewController.events = events
                            viewController.searchTerm = self.searchEntry
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: "Please Enter more than two characters of text", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Please enter a value to search", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func searchByLocationAction(_ sender: Any) {
    }
    @IBAction func interestedPreviousAction(_ sender: Any) {
        savedIndex -= 1
        displaySavedEvents(index: savedIndex)
    }
    @IBAction func interestedNextAction(_ sender: Any) {
        savedIndex += 1
        displaySavedEvents(index: savedIndex)
    }
    @IBAction func attendingPreviousAction(_ sender: Any) {
        attendingIndex -= 1
        displayAttendingEvents(index: attendingIndex)
    }
    @IBAction func attendingNextAction(_ sender: Any) {
        attendingIndex += 1
        displayAttendingEvents(index: attendingIndex)
    }
    
    @IBAction func interestedMoreAction(_ sender: Any) {
        //opens table vc and checks user has saved events
        if profile.savedEvents.count > 0 {
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "interestedTableView") as? SavedEventsTableViewController else {
                fatalError("Could not load view controller from storyboard")
            }
            viewController.events = profile.savedEvents
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let alert = UIAlertController(title: "You have not added any saved events", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func attendingMoreAction(_ sender: Any) {
        //checks user has attending events and opens up table vc
        if profile.attendingEvents.count > 0 {
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "attendingTableView") as? AttendingEventsTableViewController else {
            fatalError("Could not load view controller from storyboard")
            }
            viewController.events = profile.attendingEvents
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let alert = UIAlertController(title: "You do not have any attending events", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    func displaySavedEvents(index: Int) {
        //Displays if more than 1 event is present
        if profile.savedEvents.count > index+1 {
            singleEventInterestedLabel.isHidden = true
            leftHandInterestedEvent.isHidden = false
            rightHandInterestedEvent.isHidden = false
            leftHandInterestedEvent.text = """
            \(profile.savedEvents[index].eventName)
            
            \(profile.savedEvents[index].venue.name)
            
            \(profile.savedEvents[index].date)
            """
            
            rightHandInterestedEvent.text = """
            \(profile.savedEvents[index+1].eventName)
            
            \(profile.savedEvents[index+1].venue.name)
            
            \(profile.savedEvents[index+1].date)
            """
        //Displays if only one event is present
        } else if profile.savedEvents.count > index {
            singleEventInterestedLabel.isHidden = false
            leftHandInterestedEvent.isHidden = true
            rightHandInterestedEvent.isHidden = true
            singleEventInterestedLabel.text = """
            \(profile.savedEvents[index].eventName)
            
            \(profile.savedEvents[index].venue.name)
            
            \(profile.savedEvents[index].date)
            """
        //Displays message to user if the have no saved events.
        } else {
            singleEventInterestedLabel.isHidden = false
            leftHandInterestedEvent.isHidden = true
            rightHandInterestedEvent.isHidden = true
            singleEventInterestedLabel.text = """
            Save events to display them here!
            """

        }
        if index == 0 {
            previousInterestedEvent.isEnabled = false
        } else {
            previousInterestedEvent.isEnabled = true
        }
        if profile.savedEvents.count <= index+2 {
            nextInterestedEvent.isEnabled = false
        } else {
            nextInterestedEvent.isEnabled = true
        }
    }
    
    func displayAttendingEvents(index: Int) {
        //Displays if more than 1 event is present
        if profile.attendingEvents.count > index+1 {
            singleEventAttendingLabel.isHidden = true
            leftHandAttendingEvent.isHidden = false
            rightHandAttendingEvent.isHidden = false
            leftHandAttendingEvent.text = """
            \(profile.attendingEvents[index].eventName)
            
            \(profile.attendingEvents[index].venue.name)
            
            \(profile.attendingEvents[index].date)
            """
            
            rightHandAttendingEvent.text = """
            \(profile.attendingEvents[index+1].eventName)
            
            \(profile.attendingEvents[index+1].venue.name)
            
            \(profile.attendingEvents[index+1].date)
            """
        //Displays if only one event is present
        } else if profile.attendingEvents.count > index {
            singleEventAttendingLabel.isHidden = false
            leftHandAttendingEvent.isHidden = true
            rightHandAttendingEvent.isHidden = true
            singleEventAttendingLabel.text = """
            \(profile.attendingEvents[index].eventName)
            
            \(profile.attendingEvents[index].venue.name)
            
            \(profile.attendingEvents[index].date)
            """
        //Displays message to user if they have no saved events.
        } else {
            singleEventAttendingLabel.isHidden = false
            leftHandAttendingEvent.isHidden = true
            rightHandAttendingEvent.isHidden = true
            singleEventAttendingLabel.text = """
            Purchase events to display them here!
            """
        }
        if index == 0 {
            previousAttendingEvent.isEnabled = false
        } else {
            previousAttendingEvent.isEnabled = true
        }
        if profile.attendingEvents.count <= index+2 {
            nextAttendingEvent.isEnabled = false
        } else {
            nextAttendingEvent.isEnabled = true
        }
    }
        
    func checkEventDates() {
        //stores current date and stores each part of it
        let currentDate = Date()
        let calendar = Calendar.current
        let currentDayInt = calendar.component(.day, from: currentDate)
        let currentMonthInt = calendar.component(.month, from: currentDate)
        let currentYearInt = calendar.component(.year, from: currentDate)
        
        //creates constant format of digits for months and day
        var currentDayString = ""
        if currentDayInt < 10 {
            currentDayString = "0\(currentDayInt)"
        } else {
            currentDayString = String(currentDayInt)
        }
        
        var currentMonthString = ""
        if currentMonthInt < 10 {
            currentMonthString = "0\(currentMonthInt)"
        } else {
            currentMonthString = String(currentDayInt)
        }
        
        //creates an integer to distinguish between age of events
        let currentDateString = String(currentYearInt) + currentMonthString + currentDayString
        let currentDateInt = Int(currentDateString)
        
        if profile.savedEvents.count > 0 {
            var removeAt: [Int] = []
            for i in (0..<profile.savedEvents.count) {
                if currentDateInt! > profile.savedEvents[i].dateInt {
                    removeAt.append(i)
                }
            }
            //works through array to remove all locations where event is repeated
            removeAt.reverse()
            for i in removeAt {
                profile.savedEvents.remove(at: i)
                let defaults = UserDefaults.standard
                if let convertedProfile = try? NSKeyedArchiver.archivedData(withRootObject: profile, requiringSecureCoding: false) {
                    defaults.set(convertedProfile, forKey: "savedProfile")
                }
            }

        }
        
        if profile.attendingEvents.count > 0 {
            var removeAt: [Int] = []
            for i in (0..<profile.attendingEvents.count) {
                if currentDateInt! > profile.attendingEvents[i].dateInt {
                    removeAt.append(i)
                }
            }
            removeAt.reverse()
            for i in removeAt {
                profile.attendingEvents.remove(at: i)
                let defaults = UserDefaults.standard
                if let convertedProfile = try? NSKeyedArchiver.archivedData(withRootObject: profile, requiringSecureCoding: false) {
                    defaults.set(convertedProfile, forKey: "savedProfile")
                }
            }
        }
    }
    
    /*
     
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchEntry = searchBar.text {
            if searchEntry.count > 2 {
                self.searchEntry = searchEntry
                view.endEditing(true)
                searchByName()
            } else {
                let alert = UIAlertController(title: "Please Enter more than two characters of text", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Please enter a value to search", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
 
     */
}
