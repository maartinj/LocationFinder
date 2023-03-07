//
//  Location.swift
//  Location Finder
//
//  Created by Marcin Jędrzejak on 06/03/2023.
//

import Foundation

/*
 {
   "post code": "V7M",
   "country": "Canada",
   "country abbreviation": "CA",
   "places": [
     {
       "place name": "North Vancouver Southwest Central",
       "longitude": "-123.0798",
       "state": "British Columbia",
       "state abbreviation": "BC",
       "latitude": "49.3111"
     }
   ]
 }
 */

struct Location: Codable {
    var country: String
    struct Place: Codable {
        var placeName: String
        var longitude: String
        var state: String
        var latitude: String
        
        enum CodingKeys: String, CodingKey {
            case placeName = "place name"
            case longitude
            case state
            case latitude
        }
    }
    var places: [Place]
}
