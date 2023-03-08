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
    @State private var code = ""
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
                if selectedCountry != .none {
                    Text(selectedCountry.range)
                    Text("Postal Code/Zip Range")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Code", text: $code)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                    Button("Get Location") {
                        Task {
                            await locationService.fetchLocation(for: selectedCountry.code, postalCode: code)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(code.isEmpty)
                    if let errorString = locationService.errorString {
                        Text(errorString)
                            .foregroundColor(.red)
                    }
                    if let locationInfo = locationService.locationInfo {
                        Text(locationInfo.placeName)
                        Text(locationInfo.state)
                        if locationService.errorString == nil {
                            MapView(longitude: locationInfo.longitude, latitude: locationInfo.latitude)
                                .padding()
                        }
                    }
                }
                if locationService.locationInfo == nil {
                    Image("locationFinder")
                }
                Spacer()
            }
            .navigationTitle("Location Finder")
            .onChange(of: selectedCountry) { _ in
                code = ""
            }
            .onChange(of: code) { _ in
                locationService.reset()
            }
        }
    }
}

struct LocationFinderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFinderView()
    }
}
