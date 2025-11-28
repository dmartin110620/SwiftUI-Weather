//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "\(viewModel.location)")
                
                if viewModel.isLoading {
                    ProgressView("Loading weather...")
                        .scaleEffect(1.2)
                        .foregroundStyle(.white)
                        .padding(.bottom, 50)
                } else if let currentWeather = viewModel.currentWeather {
                    MainWeatherStatusView (
                        imageName: isNight ? "moon.stars.fill" : currentWeather.imageName,
                        temperature: isNight ? currentWeather.temperature - 8 : currentWeather.temperature
                    )
                    
                    HStack(spacing:25){
                        ForEach(viewModel.forecast) { dayWeather in
                            WeatherDayView(
                                dayOfWeek: dayWeather.dayOfWeek,
                                imageName: isNight ? getNightIcon(for: dayWeather.imageName) : dayWeather.imageName,
                                temperature: isNight ? dayWeather.temperature - 8 : dayWeather.temperature
                            )
                        }
                    }
                    .padding(15)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.loadWeather()
                    }
                } label: {
                    WeatherButton(
                        title: "Refresh",
                        textColor: .black,
                        backgroundColor: Color.white.opacity(0.7)
                    )
                }
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(
                        title: "Change Day Time",
                        textColor: .black,
                        backgroundColor: (Color.white.opacity(0.7))
                    )
                }
                
                Spacer()
            }
        }
        .task {
            await viewModel.loadWeather()
        }
    }
    
    private func getNightIcon(for dayIcon: String) -> String {
        let nightMappings: [String: String] = [
            "sun.max": "moon.stars.fill",
            "cloud.sun": "cloud.moon.fill",
            "cloud": "cloud",
            "cloud.rain": "cloud.moon.rain.fill"
        ]
        return nightMappings[dayIcon] ?? "moon.stars.fill"
    }
}

#Preview {
    ContentView()
}
