//
//  Country.swift
//  Location Finder
//
//  Created by Marcin Jędrzejak on 06/03/2023.
//

// Film: 12:10

import Foundation

struct Country: Codable, Hashable {
    let name: String
    let code: String
    let range: String
    
    static var none: Country {
        Country(name: "Select Country", code: "XX", range: "")
    }
}
