//
//  LocationService.swift
//  Location Finder
//
//  Created by Marcin Jędrzejak on 07/03/2023.
//

import Foundation

class LocationService: ObservableObject {
    @Published var countries: [Country] = []
    let baseURL = "https:api.zippopotam.us"
    
    struct LocationInfo {
        let placeName: String
        let state: String
        let longitude: Double
        let latitude: Double
    }
    
    @Published var locationInfo: LocationInfo?
    @Published var errorString: String?
    
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
    
    @MainActor
    func fetchLocation(for countryCode: String, postalCode: String) async {
        guard let urlString = (baseURL + "/" + countryCode + "/" + postalCode)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: urlString)
        else {
            errorString = "Invalid code entered."
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let location = try JSONDecoder().decode(Location.self, from: data)
            if let place = location.places.first {
                locationInfo = LocationInfo(placeName: place.placeName,
                                            state: place.state,
                                            longitude: Double(place.longitude) ?? 0,
                                            latitude: Double(place.latitude) ?? 0)
            }
        } catch {
            errorString = "Could not decode returned result."
        }
    }
    
    func reset() {
        locationInfo = nil
        errorString = nil
    }
}
