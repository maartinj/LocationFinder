//
//  LocationService.swift
//  Location Finder
//
//  Created by Marcin Jędrzejak on 07/03/2023.
//

import Foundation

class LocationService: ObservableObject {
    @Published var countries: [Country] = []
    
    
    init() {
        loadCountries()
    }
    
    func loadCountries() {
        guard let url = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            fatalError("Failed to locate Countries.json in the bundle")
        }
        guard let data  = try? Data(contentsOf: url) else {
            fatalError("Failed to load Countries.json from the bundle")
        }
        
        do {
            countries = try JSONDecoder().decode([Country].self, from: data)
            countries.insert(Country.none, at: 0)
        } catch {
            fatalError("Failed to decode Countries.json from data")
        }
    }
}
