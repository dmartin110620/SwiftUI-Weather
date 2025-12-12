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
    @State private var searchText: String = ""
    
//    var filteredCities: [City] {
//        if searchText.isEmpty { return cities }
//        return cities.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            BackgroundView(isNight: true)
            
            TabView(selection: $selectedCity) {
                ForEach(cities) { city in
                    CityWeatherView(city: city)
                        .tag(city)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .ignoresSafeArea(.all)
            
//            if filteredCities.count > 1 {
//                HStack(spacing: 10) {
//                    ForEach(filteredCities) { city in
//                        Circle()
//                            .frame(width: 10, height: 10)
//                            .foregroundColor(city.id == selectedCity.id ? .white : .gray.opacity(0.4))
//                            .glassEffect(.clear)
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 15)
//                .glassEffect(.clear)
//                .animation(.easeInOut, value: selectedCity)
//            }
        }
    }
}

#Preview {
    ContentView()
}
