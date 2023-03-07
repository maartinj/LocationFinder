//
//  LocationFinderView.swift
//  Location Finder
//
//  Created by Marcin Jędrzejak on 06/03/2023.
//

// Playlista: https://www.youtube.com/watch?v=C8FWpccVYro&list=PLBn01m5Vbs4CTP6FpTWG0ZPDTyj4Fpt-3&ab_channel=StewartLynch

// Apipheny site for Free APIs: https://apipheny.io/free-api/

import SwiftUI

struct LocationFinderView: View {
    @StateObject private var locationService = LocationService()
    @State private var selectedCountry = Country.none
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Country", selection: $selectedCountry) {
                    ForEach(locationService.countries, id: \.code) { country in
                        Text(country.name).tag(country)
                    }
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            .navigationTitle("Location Finder")
        }
    }
}

struct LocationFinderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFinderView()
    }
}
