//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/25/25.
//

import SwiftUI

struct ContentView: View {
    
    let city: City
    @StateObject private var viewModel: WeatherViewModel
    @State private var selectedCity: City
    @State private var cities: [City] = DefaultCities.cities
    @State private var searchText: String = ""
    
    init(city: City) {
        self.city = city
        _viewModel = StateObject(wrappedValue: WeatherViewModel(city: city))
        self._selectedCity = State(initialValue: city)
    }
    
    var filteredCities: [City] {
        if searchText.isEmpty { return cities }
        return cities.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            BackgroundView(isNight: viewModel.isNight)
                .animation(.easeInOut(duration: 0.35), value: viewModel.isNight)
                .transition(.opacity)
            
            TabView(selection: $selectedCity) {
                ForEach(cities) { city in
                    CityWeatherView(city: city)
                        .tag(city)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .ignoresSafeArea(.container)
            .onChange(of: selectedCity) { oldValue, newValue in
                viewModel.updateCity(newValue)
            }
        }
        .task {
            await viewModel.loadWeather()
        }
    }
}

#Preview {
    ContentView(city: DefaultCities.cities.first!)
}
