//
//  LocationFinderView.swift
//  Location Finder
//
//  Created by Marcin Jędrzejak on 06/03/2023.
//

import SwiftUI

struct LocationFinderView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFinderView()
    }
}
