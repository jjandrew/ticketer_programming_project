//
//  Demographic.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 20/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation
import Firebase

class Demographic {
    let db = Firestore.firestore()
    let event: Event
    var numberFemaleInterested: Int
    var numberMaleInterested: Int
    var numberOtherInterested: Int
    var numberFemaleAttending: Int
    var numberMaleAttending: Int
    var numberOtherAttending: Int
    var totalAgeAttending: Int
    var totalAgeInterested: Int
    var totalAttending: Int
    var totalInterested: Int
    
    init(event: Event, numberFemaleInterested: Int, numberMaleInterested: Int, numberOtherInterested: Int, numberFemaleAttending: Int, numberMaleAttending: Int, numberOtherAttending: Int, totalAgeAttending: Int, totalAgeInterested: Int, totalAttending: Int, totalInterested: Int) {
        self.event = event
        self.numberFemaleInterested = numberFemaleInterested
        self.numberMaleInterested = numberMaleInterested
        self.numberOtherInterested = numberOtherInterested
        self.numberFemaleAttending = numberFemaleAttending
        self.numberMaleAttending = numberMaleAttending
        self.numberOtherAttending = numberOtherAttending
        self.totalAgeAttending = totalAgeAttending
        self.totalAgeInterested = totalAgeInterested
        self.totalAttending = totalAttending
        self.totalInterested = totalInterested
    }
    
    
    
    func calculateAverageAgeInterested() -> String {
        if totalInterested == 0 {
            return "N/A"
        }
        let average = Float(totalAgeInterested)/Float(totalInterested)
        return String(format: "%.2f", average)
    }
    
    func calculateAverageAgeAttending() -> String {
        if totalAttending == 0 {
            return "N/A"
        }
        let average = Float(totalAgeAttending)/Float(totalAttending)
        return String(format: "%.2f", average)
    }
    
    func calculateInterestedPercentages() -> [String] {
        if totalInterested == 0 {
            return ["N/A","N/A","N/A"]
        }
        var percentageArray: [String] = []
        //will calculate percentage for each and make to 0 decimal places
        let malePercentage = (Float(numberMaleInterested)/Float(totalInterested))*100
        percentageArray.append(String(format: "%.0f", malePercentage))
        let femalePercentage = (Float(numberFemaleInterested)/Float(totalInterested))*100
        percentageArray.append(String(format: "%.0f", femalePercentage))
        let otherPercentage = (Float(numberOtherInterested)/Float(totalInterested))*100
        percentageArray.append(String(format: "%.0f", otherPercentage))
        //will return array in format [malePercentage, femalePercentage, otherPercentage]
        return percentageArray
    }
    
    func calculateAttendingPercentages() -> [String] {
        if totalAttending == 0 {
            return ["N/A","N/A","N/A"]
        }
        var percentageArray: [String] = []
        //will calculate percentage for each and make to 0 decimal places
        let malePercentage = (Float(numberMaleAttending)/Float(totalAttending))*100
        percentageArray.append(String(format: "%.0f", malePercentage))
        let femalePercentage = (Float(numberFemaleAttending)/Float(totalAttending))*100
        percentageArray.append(String(format: "%.0f", femalePercentage))
        let otherPercentage = (Float(numberOtherAttending)/Float(totalAttending))*100
        percentageArray.append(String(format: "%.0f", otherPercentage))
        //will return array in format [malePercentage, femalePercentage, otherPercentage]
        return percentageArray
    }
    
    
    func checkDocumentPresent() {
        var ref: DocumentReference!
        let db = Firestore.firestore()
        //this will be changed to the identifier of the event
        ref = db.document("events/\(self.event.identifier)")
        ref.getDocument() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if querySnapshot?.data() == nil {
                    print("Event not present")
                    //create new event
                } else {
                    print("Event present")
                    //create demographic instance
                    //prepare to update demographic
                }
            }
        }
    }
    
    func updateDocumentForSaved() {
        //updates demographics and stores constant value to be updated
        let newTotalAgeInterested = totalAgeInterested + profile.userAge!
        let newTotalInterested = totalInterested + 1
        self.totalAgeInterested += profile.userAge!
        self.totalInterested += 1
        //checks user gender in order to make sure correct values are updated
        if profile.userGender == "Male" {
            let newMaleInterested = numberMaleInterested + 1
            self.numberMaleInterested += 1
            db.document("events/\(self.event.identifier)").updateData([
                "numberMaleInterested": newMaleInterested,
                "totalAgeInterested": newTotalAgeInterested,
                "totalInterested": newTotalInterested
            ])
        } else if profile.userGender == "Female" {
            let newFemaleInterested = numberFemaleInterested + 1
            self.numberFemaleInterested += 1
            db.document("events/\(self.event.identifier)").updateData([
                "numberFemaleInterested": newFemaleInterested,
                "totalAgeInterested": newTotalAgeInterested,
                "totalInterested": newTotalInterested
            ])
        } else {
            let newOtherInterested = numberOtherInterested + 1
            self.numberOtherInterested += 1
            db.document("events/\(self.event.identifier)").updateData([
                "numberOtherInterested": newOtherInterested,
                "totalAgeInterested": newTotalAgeInterested,
                "totalInterested": newTotalInterested
            ])
        }
    }
    
    func updateDocumentForUnsaved() {
        let newTotalAgeInterested = totalAgeInterested - profile.userAge!
        let newTotalInterested = totalInterested - 1
        self.totalAgeInterested -= profile.userAge!
        if self.totalInterested > 0 {
            self.totalInterested -= 1
            if profile.userGender == "Male" {
                let newMaleInterested = numberMaleInterested - 1
                self.numberMaleInterested -= 1
                    db.document("events/\(self.event.identifier)").updateData([
                        "numberMaleInterested": newMaleInterested,
                        "totalAgeInterested": newTotalAgeInterested,
                        "totalInterested": newTotalInterested
                    ])
            } else if profile.userGender == "Female" {
                let newFemaleInterested = numberFemaleInterested - 1
                self.numberFemaleInterested -= 1
                db.document("events/\(self.event.identifier)").updateData([
                    "numberFemaleInterested": newFemaleInterested,
                    "totalAgeInterested": newTotalAgeInterested,
                    "totalInterested": newTotalInterested
                ])
            } else {
                let newOtherInterested = numberOtherInterested - 1
                self.numberOtherInterested -= 1
                db.document("events/\(self.event.identifier)").updateData([
                    "numberOtherInterested": newOtherInterested,
                    "totalAgeInterested": newTotalAgeInterested,
                    "totalInterested": newTotalInterested
                ])
            }
        } else {
            db.document("events/\(self.event.identifier)").updateData([
                "numberMaleInterested": 0,
                "numberFemaleInterested": 0,
                "numberOtherInterested": 0,
                "totalAgeInterested": 0,
                "totalInterested": 0
            ])
        }
    }
    
    func updateDocumentForAttendingAdded() {
        //updates demographics and stores constant value to be updated
        let newTotalAgeAttending = totalAgeAttending + profile.userAge!
        let newTotalAttending = totalAttending + 1
        self.totalAgeAttending += profile.userAge!
        self.totalAttending += 1
        if profile.userGender == "Male" {
            let newMaleAttending = numberMaleAttending + 1
            self.numberMaleAttending += 1
            db.document("events/\(self.event.identifier)").updateData([
                "numberMaleAttending": newMaleAttending,
                "totalAgeAttending": newTotalAgeAttending,
                "totalAttending": newTotalAttending
            ])
        } else if profile.userGender == "Female" {
            let newFemaleAttending = numberFemaleAttending + 1
            self.numberFemaleAttending += 1
            db.document("events/\(self.event.identifier)").updateData([
                "numberFemaleAttending": newFemaleAttending,
                "totalAgeAttending": newTotalAgeAttending,
                "totalAttending": newTotalAttending
            ])
        } else {
            let newOtherAttending = numberOtherAttending + 1
            self.numberOtherAttending += 1
            db.document("events/\(self.event.identifier)").updateData([
                "numberOtherAttending": newOtherAttending,
                "totalAgeAttending": newTotalAgeAttending,
                "totalAttending": newTotalAttending
            ])
        }
    }
    
    func updateDocumentForAttendingRemoved() {
        //updates demographics and stores constant value to be updated
        let newTotalAgeAttending = totalAgeAttending - profile.userAge!
        let newTotalAttending = totalAttending - 1
        self.totalAgeAttending -= profile.userAge!
        if self.totalAttending > 0 {
            self.totalAttending -= 1
            if profile.userGender == "Male" {
                let newMaleAttending = numberMaleAttending - 1
                self.numberMaleAttending -= 1
                db.document("events/\(self.event.identifier)").updateData([
                    "numberMaleAttending": newMaleAttending,
                    "totalAgeAttending": newTotalAgeAttending,
                    "totalAttending": newTotalAttending
                ])
            } else if profile.userGender == "Female" {
                let newFemaleAttending = numberFemaleAttending - 1
                self.numberFemaleAttending -= 1
                db.document("events/\(self.event.identifier)").updateData([
                    "numberFemaleAttending": newFemaleAttending,
                    "totalAgeAttending": newTotalAgeAttending,
                    "totalAttending": newTotalAttending
                ])
            } else {
                let newOtherAttending = numberOtherAttending - 1
                self.numberOtherAttending -= 1
                db.document("events/\(self.event.identifier)").updateData([
                    "numberOtherAttending": newOtherAttending,
                    "totalAgeAttending": newTotalAgeAttending,
                    "totalAttending": newTotalAttending
                ])
            }
        } else {
            db.document("events/\(self.event.identifier)").updateData([
                "numberMaleAttending": 0,
                "numberFemaleAttending": 0,
                "numberOtherAttending": 0,
                "totalAgeAttending": 0,
                "totalAttending": 0
            ])
        }
    }
}
