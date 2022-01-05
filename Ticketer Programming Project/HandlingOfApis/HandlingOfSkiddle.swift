//
//  ProfileViewController.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 27/09/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HandlingOfSkiddle {
    let baseUrl = "https://www.skiddle.com/api/v1/events/search/?"
    let apiKey = "api_key=52f07458a25911d3e1b89ab9f7f0c448"
    let decoder = JSONDecoder()
    var jsonString = ""
    var skiddleEvents: SkiddleEventResponse? = nil
    var events: [Event] = []

    
    func createUrlForName(term: String?) -> String? {
        guard let searchTerm = term else {
            print("No search term provided")
            return nil}
        
        let path = "&keyword=\(searchTerm)&order=date&description=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = baseUrl + apiKey + path
        return url
    }
    
    func createUrlForLocation() -> String? {
        if profile.userLatitude != nil {
            let path = "&latitude=\(profile.userLatitude!)&longitude=\( profile.userLongitude!)&radius=20&order=date&description=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            let url = baseUrl + apiKey + path
            return url
        }
        print("Error creating URL")
        return nil
    }
    
    
    func createJsonString(urlEntry: String, completion: @escaping ([Event]) -> Void) {
        if let url = URL(string: urlEntry) {
            //performs the retrival function from the API
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                //checks that there are no errors
                if let error = error {
                    print(error)
                } else {
                    if let data = data {
                        //stores json as a string and calls decoding function
                        if let jsonString = String(data: data, encoding: .utf8) {
                            self.jsonString = jsonString
                            let _ = JSON(jsonString)
                            if let response = self.parsingJson(json: data) {
                                self.skiddleEvents = response
                                if let events = (self.skiddleEvents?.convertToEventClass()) {
                                    self.events = events
                                }
                            }
                        } else {
                            print("Error creating json string")
                        }
                    }
                }
                completion(self.events)
            }.resume()
                
        } else {
            print("Error creating URL")
        }
    }
    
    func parsingJson(json: Data) -> SkiddleEventResponse? {
        //decodes event to classes
        if let eventResponse = try?decoder.decode(SkiddleEventResponse.self, from: json) {
            return eventResponse
        } else {
            print("Failed to decode to Event Response")
            return nil
        }
    }
}
