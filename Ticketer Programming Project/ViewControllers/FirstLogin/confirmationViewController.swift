//
//  confirmationViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 07/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit

class confirmationViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateOfBirthLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up default values of UI
        nameLabel.text = profile.userName
        dateOfBirthLabel.text = profile.userBirthdayString
        genderLabel.text = profile.userGender
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        profile.loggedIn = true
        //saves profile to local storage
        let defaults = UserDefaults.standard
        if let convertedProfile = try? NSKeyedArchiver.archivedData(withRootObject: profile, requiringSecureCoding: false) {
            defaults.set(convertedProfile, forKey: "savedProfile")
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        performSegue(withIdentifier: "confirmToHome", sender: self)
    }
    
}



