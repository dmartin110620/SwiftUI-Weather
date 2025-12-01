//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedCity: City = DefaultCities.cities[0]
    @State private var cities: [City] = DefaultCities.cities
    
    var body: some View {
        TabView(selection: $selectedCity) {
            ForEach(cities) { city in CityWeatherView(city: city)
                    .tabItem {
                        Label(city.name, systemImage: getCityIcon(for: city.name))
                    }
                    .tag(city)
            }
        }
        .accentColor(.blue)
    }
    private func getCityIcon(for cityName: String) -> String {
        switch cityName {
        case "New York": return "building.2"
        case "London": return "crown"
        case "Tokyo": return "mountain.2"
        case "Paris": return "eurosign"
        case "Sydney": return "sun.max"
        case "Dubai": return "sun.dust"
        case "São Paulo": return "leaf"
        default: return "location"
        }
    }
}

#Preview {
    ContentView()
}
