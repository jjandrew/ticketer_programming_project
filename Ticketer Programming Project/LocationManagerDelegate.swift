//
//  LocationManagerDelegate.swift
//  Ticketer Programming Project
//
//  Created by JJ Andrew on 24/11/2020.
//  Copyright © 2020 JJ Andrew. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    let geocoder = CLGeocoder()
    weak var vc: HomeScreenViewController?

    //checks that there is no error accessing location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        vc?.currentLocationLabel.text = "Unable to access location"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            //stores the parts of a user's location into the profile class
            profile.userLongitude = String(firstLocation.coordinate.longitude)
            profile.userLatitude = String(firstLocation.coordinate.latitude)
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.vc?.currentLocationLabel.text = "Unable to access location"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        profile.userLocation = placemarks?[0].locality
                        self.vc?.currentLocationLabel.text = placemarks?[0].locality
                    }
                }
            })
        }
    }
    
}

