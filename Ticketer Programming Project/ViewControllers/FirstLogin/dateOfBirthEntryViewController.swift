//
//  dateOfBirthEntryViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 07/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit

class dateOfBirthEntryViewController: UIViewController {

    @IBOutlet var dateOfBirthPicker: UIDatePicker!
    let currentDate = Date()
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func entryButton(_ sender: Any) {
        let dOfB = dateOfBirthPicker.date
        let userAge = calculateAge(dOfB: dOfB)
        //validates age
        if userAge > 4 && userAge < 126 {
            //places age into constant date format
            profile.userBirthdayDate = dOfB
            profile.userAge = userAge
            let dOfBDayInt = calendar.component(.day, from: dOfB)
            var dOfBDayString = ""
            if dOfBDayInt < 10 {
                dOfBDayString = "0\(dOfBDayInt)"
            } else {
                dOfBDayString = String(dOfBDayInt)
            }
            let dOfBMonthInt = calendar.component(.month, from: dOfB)
            var dOfBMonthString = ""
            if dOfBMonthInt < 10 {
                dOfBMonthString = "0\(dOfBMonthInt)"
            } else {
                dOfBMonthString = String(dOfBDayInt)
            }
            let dOfBYear = calendar.component(.year, from: dOfB)
            profile.userBirthdayString = "\(dOfBDayString)/\(dOfBMonthString)/\(dOfBYear)"
            performSegue(withIdentifier: "DOBToGender", sender: self)
        } else {
            let alert = UIAlertController(title: "I'm sorry your age means you are not eligible to using our application", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

    func calculateAge(dOfB: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: dOfB, to: currentDate).year ?? 0
    }

}

