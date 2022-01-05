//
//  searchSortingChoiceViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 02/11/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit

class searchSortingChoiceViewController: UIViewController {

    var events: [Event] = []
    let sortAndSearch = SortAndSearch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.events = eventSearchStruct.events
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sortByName(_ sender: Any) {
        let sortedEvents = sortAndSearch.quickSortByName(array: events)
        eventSearchStruct.events = sortedEvents
        //send sorted events back to searchvc
    }
    
    @IBAction func sortByDate(_ sender: Any) {
    }

}
