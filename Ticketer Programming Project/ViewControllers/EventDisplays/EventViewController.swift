//
//  EventViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 04/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController {

    @IBOutlet var savedButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var venueLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var demographicLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    @IBOutlet var totalInterestedLabel: UILabel!
    @IBOutlet var totalAttendingLabel: UILabel!
    @IBOutlet var averageAttendingLabel: UILabel!
    @IBOutlet var averageInterestedLabel: UILabel!
    @IBOutlet var percentagesInterestedLabel: UILabel!
    @IBOutlet var maleInterestedLabel: UILabel!
    @IBOutlet var femaleInterestedLabel: UILabel!
    @IBOutlet var otherInterestedLabel: UILabel!
    @IBOutlet var percentagesAttendingLabel: UILabel!
    @IBOutlet var maleAttendingLabel: UILabel!
    @IBOutlet var femaleAttendingLabel: UILabel!
    @IBOutlet var otherAttendingLabel: UILabel!
    @IBOutlet var eventNameLabel: UILabel!
    
    var event: Event!
    let sortAndSearch = SortAndSearch()
    var demographic: Demographic? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets default values for opening view
        savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        navigationItem.title = event.eventName
        eventNameLabel.text = event.eventName
        dateLabel.text = event.date
        descriptionLabel.text = event.summary
        venueLabel.text = """
        \(event.venue.name)
        \(event.venue.town)
        \(event.venue.country)
        \(event.venue.postCode)
        """
        if sortAndSearch.eventLinearSearch(events: profile.savedEvents, searchEvent: event).1 == true {
            savedButton.isSelected = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        readFirestore()
    }
    
    func readFirestore() {
        var ref: DocumentReference!
        let db = Firestore.firestore()
        //creation of identifier of event to be used for reference
        self.event.createIdentifier()
        ref = db.document("events/\(event.identifier)")
        ref.getDocument() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if querySnapshot?.data() == nil {
                    print("Event not present")
                    self.demographic = nil
                    //outputs no demographics present to screen
                    self.updateDemographicLabels()
                    //create new event
                } else {
                    let data = querySnapshot?.data()
                    print("Event present")
                    //create demographic instance
                    self.demographic = Demographic(event: self.event, numberFemaleInterested: data!["numberFemaleInterested"] as! Int, numberMaleInterested: data!["numberMaleInterested"] as! Int, numberOtherInterested: data!["numberOtherInterested"] as! Int, numberFemaleAttending: data!["numberFemaleAttending"] as! Int, numberMaleAttending: data!["numberMaleAttending"] as! Int, numberOtherAttending: data!["numberOtherAttending"] as! Int, totalAgeAttending: data!["totalAgeAttending"] as! Int, totalAgeInterested: data!["totalAgeInterested"] as! Int, totalAttending: data!["totalAttending"] as! Int, totalInterested: data!["totalInterested"] as! Int)
                    self.event.demographic = self.demographic
                    self.updateDemographicLabels()
                }
            }
        }
    }
    
    func updateDemographicLabels() {
        if self.demographic == nil {
            self.demographicLabel.text = "No Demographic available"
            self.totalInterestedLabel.isHidden = true
            self.totalAttendingLabel.isHidden = true
            self.averageAttendingLabel.isHidden = true
            self.averageInterestedLabel.isHidden = true
            self.percentagesInterestedLabel.isHidden = true
            self.maleInterestedLabel.isHidden = true
            self.femaleInterestedLabel.isHidden = true
            self.otherInterestedLabel.isHidden = true
            self.percentagesAttendingLabel.isHidden = true
            self.maleAttendingLabel.isHidden = true
            self.femaleAttendingLabel.isHidden = true
            self.otherAttendingLabel.isHidden = true
        } else if (self.demographic?.totalInterested == 0) && (self.demographic?.totalAttending == 0) {
            self.demographicLabel.text = "No Demographic available"
            self.totalInterestedLabel.isHidden = true
            self.totalAttendingLabel.isHidden = true
            self.averageAttendingLabel.isHidden = true
            self.averageInterestedLabel.isHidden = true
            self.percentagesInterestedLabel.isHidden = true
            self.maleInterestedLabel.isHidden = true
            self.femaleInterestedLabel.isHidden = true
            self.otherInterestedLabel.isHidden = true
            self.percentagesAttendingLabel.isHidden = true
            self.maleAttendingLabel.isHidden = true
            self.femaleAttendingLabel.isHidden = true
            self.otherAttendingLabel.isHidden = true
        } else {
            //output values to screen
            self.demographicLabel.text = "Demographics:"
            self.totalInterestedLabel.isHidden = false
            self.totalAttendingLabel.isHidden = false
            self.averageAttendingLabel.isHidden = false
            self.averageInterestedLabel.isHidden = false
            self.percentagesInterestedLabel.isHidden = false
            self.maleInterestedLabel.isHidden = false
            self.femaleInterestedLabel.isHidden = false
            self.otherInterestedLabel.isHidden = false
            self.percentagesAttendingLabel.isHidden = false
            self.maleAttendingLabel.isHidden = false
            self.femaleAttendingLabel.isHidden = false
            self.otherAttendingLabel.isHidden = false
            self.totalInterestedLabel.text = "Total Users Interested: \(String(self.demographic!.totalInterested))"

            self.totalAttendingLabel.text = "Total Users Attending: \(String(self.demographic!.totalAttending))"
            
            self.averageAttendingLabel.text = "Average Age Attending: \(String(self.demographic!.calculateAverageAgeAttending()))"
            
            self.averageInterestedLabel.text = "Average Age Interested: \(String(self.demographic!.calculateAverageAgeInterested()))"
            
            //order of demographic percentages is [malePercentage, femalePercentage, otherPercentage]
            let gendersInterested = self.demographic!.calculateInterestedPercentages()
            self.maleInterestedLabel.text = "Male: \(gendersInterested[0])"
            self.femaleInterestedLabel.text = "Female: \(gendersInterested[1])"
            self.otherInterestedLabel.text = "Other: \(gendersInterested[2])"
            
            let gendersAttending = self.demographic!.calculateAttendingPercentages()
            self.maleAttendingLabel.text = "Male: \(gendersAttending[0])"
            self.femaleAttendingLabel.text = "Female: \(gendersAttending[1])"
            self.otherAttendingLabel.text = "Other: \(gendersAttending[2])"
            //prepare to update demographic
        }
    }

    @IBAction func savedAction(_ sender: Any) {
        //saves and unsaves the event
        if savedButton.isSelected == true {
            //checks location of event in savedEvents
            profile.savedEvents.remove(at: sortAndSearch.eventLinearSearch(events: profile.savedEvents, searchEvent: event).0!)
            savedButton.isSelected = false
            demographic?.updateDocumentForUnsaved()
            updateDemographicLabels()
        } else {
            savedButton.isSelected = true
            profile.savedEvents.append(event)
            if event.demographic == nil {
                createDocumentInterested()
                readFirestore()
            } else {
                demographic?.updateDocumentForSaved()
                updateDemographicLabels()
            }
        }
        //saves event to local storage
        let defaults = UserDefaults.standard
        if let convertedProfile = try? NSKeyedArchiver.archivedData(withRootObject: profile, requiringSecureCoding: false) {
            defaults.set(convertedProfile, forKey: "savedProfile")
        }
        if let convertedEvents = try? NSKeyedArchiver.archivedData(withRootObject: profile.savedEvents, requiringSecureCoding: false) {
            defaults.set(convertedEvents, forKey: "savedEvents")
        }
    }
    
    @IBAction func purchaseAction(_ sender: Any) {
        //checks event is present in attending events
        if sortAndSearch.eventLinearSearch(events: profile.attendingEvents, searchEvent: event).1 == false {
            profile.attendingEvents.append(event)
            //adds event to demographic
            if event.demographic == nil {
                createDocumentAttending()
                readFirestore()
            } else {
                demographic?.updateDocumentForAttendingAdded()
                updateDemographicLabels()
            }
        }
        //stores profile in local storage
        let defaults = UserDefaults.standard
        if let convertedProfile = try? NSKeyedArchiver.archivedData(withRootObject: profile, requiringSecureCoding: false) {
            defaults.set(convertedProfile, forKey: "savedProfile")
        }
        if let convertedEvents = try? NSKeyedArchiver.archivedData(withRootObject: profile.attendingEvents, requiringSecureCoding: false) {
            defaults.set(convertedEvents, forKey: "attendingEvents")
        }
        //opens website in safari
        let website = self.event.website[0]
        UIApplication.shared.open(URL(string: website)!)
    }
    
    
    func createDocumentInterested() {
        var ref: DocumentReference!
        ref = Firestore.firestore().document("events/\(self.event.identifier)")
        if profile.userGender == "Male" {
            let data: [String: Any] = [
                "numberFemaleInterested": 0,
                "numberMaleInterested": 1,
                "numberOtherInterested": 0,
                "numberFemaleAttending": 0,
                "numberMaleAttending": 0,
                "numberOtherAttending": 0,
                "totalAgeAttending": 0,
                "totalAgeInterested": profile.userAge!,
                "totalAttending": 0,
                "totalInterested": 1
            ]
            ref.setData(data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    self.updateDemographicLabels()
                }
            }
        } else if profile.userGender == "Female" {
            let data: [String: Any] = [
                "numberFemaleInterested": 1,
                "numberMaleInterested": 0,
                "numberOtherInterested": 0,
                "numberFemaleAttending": 0,
                "numberMaleAttending": 0,
                "numberOtherAttending": 0,
                "totalAgeAttending": 0,
                "totalAgeInterested": profile.userAge!,
                "totalAttending": 0,
                "totalInterested": 1
            ]
            ref.setData(data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        } else {
            let data: [String: Any] = [
                "numberFemaleInterested": 0,
                "numberMaleInterested": 0,
                "numberOtherInterested": 1,
                "numberFemaleAttending": 0,
                "numberMaleAttending": 0,
                "numberOtherAttending": 0,
                "totalAgeAttending": 0,
                "totalAgeInterested": profile.userAge!,
                "totalAttending": 0,
                "totalInterested": 1
            ]
            ref.setData(data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
        
    }
    
    func createDocumentAttending() {
        var ref: DocumentReference!
        ref = Firestore.firestore().document("events/\(self.event.identifier)")
        if profile.userGender == "Male" {
            let data: [String: Any] = [
                "numberFemaleInterested": 0,
                "numberMaleInterested": 0,
                "numberOtherInterested": 0,
                "numberFemaleAttending": 0,
                "numberMaleAttending": 1,
                "numberOtherAttending": 0,
                "totalAgeAttending": profile.userAge!,
                "totalAgeInterested": 0,
                "totalAttending": 1,
                "totalInterested": 0
            ]
            ref.setData(data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        } else if profile.userGender == "Female" {
            let data: [String: Any] = [
                "numberFemaleInterested": 0,
                "numberMaleInterested": 0,
                "numberOtherInterested": 0,
                "numberFemaleAttending": 1,
                "numberMaleAttending": 0,
                "numberOtherAttending": 0,
                "totalAgeAttending": profile.userAge!,
                "totalAgeInterested": 0,
                "totalAttending": 1,
                "totalInterested": 0
            ]
            ref.setData(data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        } else {
            let data: [String: Any] = [
                "numberFemaleInterested": 0,
                "numberMaleInterested": 0,
                "numberOtherInterested": 0,
                "numberFemaleAttending": 0,
                "numberMaleAttending": 0,
                "numberOtherAttending": 1,
                "totalAgeAttending": profile.userAge!,
                "totalAgeInterested": 0,
                "totalAttending": 1,
                "totalInterested": 0
            ]
            ref.setData(data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let items = [URL(string: event.website[0])!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}
