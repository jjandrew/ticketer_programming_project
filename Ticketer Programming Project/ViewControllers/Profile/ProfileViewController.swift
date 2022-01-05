//
//  ProfileViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 27/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    
    @IBOutlet var leftHandInterestedEvent: UILabel!
    @IBOutlet var rightHandInterestedEvent: UILabel!
    @IBOutlet var leftHandAttendingEvent: UILabel!
    @IBOutlet var rightHandAttendingEvent: UILabel!
    @IBOutlet var interestedMoreButton: UIButton!
    @IBOutlet var previousInterestedEvent: UIButton!
    @IBOutlet var nextInterestedEvent: UIButton!
    @IBOutlet var attendingMoreButton: UIButton!
    @IBOutlet var previousAttendingEvent: UIButton!
    @IBOutlet var nextAttendingEvent: UIButton!
    @IBOutlet var singleEventInterestedLabel: UILabel!
    @IBOutlet var singleEventAttendingLabel: UILabel!
    
    
    var savedIndex = 0
    var attendingIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //sets default values for view controller labels
        savedIndex = 0
        attendingIndex = 0
        displaySavedEvents(index: savedIndex)
        displayAttendingEvents(index: attendingIndex)
        nameLabel.text = "Name: \(profile.userName)"
        birthdayLabel.text = "Birthday: \(profile.userBirthdayString)"
        genderLabel.text = "Gender: \(profile.userGender)"
    }
    
    @IBAction func interestedMoreButtonAction(_ sender: Any) {
        //performs validation on saved events and opens up table vc if they succeed
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
    @IBAction func interestedPrevButton(_ sender: Any) {
        savedIndex -= 1
        displaySavedEvents(index: savedIndex)
    }
    @IBAction func interestedNextButton(_ sender: Any) {
        savedIndex += 1
        displaySavedEvents(index: savedIndex)
    }
    @IBAction func attendingMoreButtonAction(_ sender: Any) {
        //performs validation on attending events and opens up table vc if they succeed
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
    
    @IBAction func attendingPrevButton(_ sender: Any) {
        attendingIndex -= 1
        displayAttendingEvents(index: attendingIndex)
    }
    @IBAction func attendingNextButton(_ sender: Any) {
        attendingIndex += 1
        displayAttendingEvents(index: attendingIndex)
    }
    
    func displaySavedEvents(index: Int) {
        //sets values of events display on vc
        //Two or more events present
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
        //One event present
        } else if profile.savedEvents.count > index {
            singleEventInterestedLabel.isHidden = false
            leftHandInterestedEvent.isHidden = true
            rightHandInterestedEvent.isHidden = true
            singleEventInterestedLabel.text = """
            \(profile.savedEvents[index].eventName)
            
            \(profile.savedEvents[index].venue.name)
            
            \(profile.savedEvents[index].date)
            """
        //No events present
        } else {
            singleEventInterestedLabel.isHidden = false
            leftHandInterestedEvent.isHidden = true
            rightHandInterestedEvent.isHidden = true
            singleEventInterestedLabel.text = """
            Save events to display them here!
            """
        }
        //possibility handling of number of events
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
        //Two or more events present
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
        //One event present
        } else if profile.attendingEvents.count > index {
            singleEventAttendingLabel.isHidden = false
            leftHandAttendingEvent.isHidden = true
            rightHandAttendingEvent.isHidden = true
            singleEventAttendingLabel.text = """
            \(profile.attendingEvents[index].eventName)
            
            \(profile.attendingEvents[index].venue.name)
            
            \(profile.attendingEvents[index].date)
            """
        
        //No event present
        } else {
            singleEventAttendingLabel.isHidden = false
            leftHandAttendingEvent.isHidden = true
            rightHandAttendingEvent.isHidden = true
            singleEventAttendingLabel.text = """
            Purchase events to display them here!
            """
        }
        //possibility handiling of number of events
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
}
