//
//  SearchViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 07/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var events: [Event] = []
    let sortAndSearch = SortAndSearch()
    @IBOutlet var sortOutlet: UIButton!
    var searchTerm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sorts events by name when view loads
        self.events = sortAndSearch.quickSortByName(array: self.events)
        eventSearchStruct.events = self.events
        self.events = sortAndSearch.checkEventsAreDifferent(events: events)
        tableView.reloadData()
        sortOutlet.setTitle("Sort By Date", for: .normal)
        navigationItem.title = searchTerm
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(events[indexPath.row].eventName) \n\(events[indexPath.row].date)"
        return cell
    }
    
    @IBAction func sortAction(_ sender: Any) {
        if sortOutlet.currentTitle == "Sort By Date" {
            for event in events {
                event.dateIntConversion()
            }
            self.events = sortAndSearch.quickSortByDate(array: self.events)
            sortOutlet.setTitle("Sort By Name", for: .normal)
        } else {
            self.events = sortAndSearch.quickSortByName(array: self.events)
            sortOutlet.setTitle("Sort By Date", for: .normal)
        }
        tableView.reloadData()
        eventSearchStruct.events = self.events
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //opens event vc
        guard let viewController = storyboard?.instantiateViewController(identifier: "eventScene") as? EventViewController else {
            fatalError("Couldn't load event view controller")
        }
        viewController.event = events[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
