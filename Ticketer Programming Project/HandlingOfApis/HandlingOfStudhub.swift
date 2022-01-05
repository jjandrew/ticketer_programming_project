//
//  HandlingOfStudhub.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 21/10/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class HandlingOfStudhub {
    let baseUrl = "https://api.stubhub.com/sellers/search/events/v3?"
    let apiKey = "8L7GQ9U3pO2IgGBe0hD5JqHhSTFW"
    let decoder = JSONDecoder()
    var jsonString = ""
    var studhubEvents: StudhubEventResponse? = nil
    var events: [Event] = []
    let headers: HTTPHeaders = [
        "Authorization": "Bearer 8L7GQ9U3pO2IgGBe0hD5JqHhSTFW",
        "Accept": "application/json"
    ]

    
    func createUrlForName(term: String?) -> String? {
        //checks that a search term is present
        guard let searchTerm = term else {
            print("No search term provided")
            return nil}
        
        let path = "name=\(searchTerm)/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = baseUrl + path
        return url
    }
    
    func createUrlForLocation(term: String?) -> String? {
        //checks that a search term is provided
        guard let searchTerm = term else {
            print("No search term provided")
            return nil}
        
        let path = "city=\(searchTerm)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = baseUrl + path
        return url
    }
    
    func createJsonString(urlEntry: String, completion: @escaping ([Event]) -> Void) {
        if let url = URL(string: urlEntry) {
            //uses Alamofire to make an HTTP GET request
            AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
                switch response.result {
                    //checks there are no errors and stores json as a string
                    case .success(let value):
                        let json = JSON(value)
                        let jsonData = try! json.rawData()
                        self.jsonString = json.description
                        //decodes event to class
                        if let response = self.parsingJson(json: jsonData) {
                            self.studhubEvents = response
                            //converts StudHub events to a common class
                            if let events = (self.studhubEvents?.convertToEventClass()) {
                                self.events = events
                            }
                            
                        }
                        completion(self.events)

                    case .failure(let error):
                        print("oops")
                        print(error)
                        self.events = []
                    }
            }
        } else {
            print("Error creating URL")
            self.events = []
        }

    }
    
    func parsingJson(json: Data) -> StudhubEventResponse? {
        //decodes event to class
        if let eventResponse = try?decoder.decode(StudhubEventResponse.self, from: json) {
            return eventResponse
        } else {
            print("Failed to decode to Event Response")
            return nil
        }
    }
}
