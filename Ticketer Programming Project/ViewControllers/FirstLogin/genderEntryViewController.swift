//
//  genderEntryViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 07/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit

class genderEntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func maleButton(_ sender: Any) {
        profile.userGender = "Male"
        performSegue(withIdentifier: "genderToConfirm", sender: self)
    }
    
    @IBAction func femaleButton(_ sender: Any) {
        profile.userGender = "Female"
        performSegue(withIdentifier: "genderToConfirm", sender: self)
    }
    
    @IBAction func otherButton(_ sender: Any) {
        profile.userGender = "Other"
        performSegue(withIdentifier: "genderToConfirm", sender: self)
    }

}
