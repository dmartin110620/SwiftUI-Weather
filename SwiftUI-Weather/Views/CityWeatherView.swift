//
//  CityWeatherView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/30/25.
//

import SwiftUI

struct CityWeatherView: View {
    let city: City
    @StateObject private var viewModel: WeatherViewModel
    
    init (city: City) {
        self.city = city
        _viewModel = StateObject(wrappedValue: WeatherViewModel(city: city))
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: viewModel.isNight)
            
            ScrollView {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    Task {
                        await viewModel.loadWeather()
                    }
                }
                VStack {
                    VStack {
                        CityTextView(cityName: city.displayName)
                        
                        if viewModel.isLoading {
                            Spacer()
                            ProgressView("Loading forecast...")
                                .scaleEffect(1.2)
                                .foregroundStyle(.white)
                            Spacer()
                        } else if let currentWeather = viewModel.currentWeather, let forecast = viewModel.forecast.first {
                            MainWeatherStatusView(
                                imageName: currentWeather.imageName,
                                temperature: currentWeather.temperature,
                                highTemp: forecast.highTemp ?? currentWeather.temperature,
                                lowTemp: forecast.lowTemp ?? currentWeather.temperature
                            )
                            
                            HStack(spacing: 25) {
                                ForEach(viewModel.forecast) { dayWeather in
                                    WeatherDayView (
                                        dayOfWeek: dayWeather.dayOfWeek,
                                        imageName: dayWeather.imageName,
                                        temperature: dayWeather.temperature
                                    )
                                }
                            }
                            .padding(15)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding(.bottom, 20)
                            
                        } else if let error = viewModel.errorMessage {
                            ErrorView(error: error) {
                                Task {
                                    await viewModel.loadWeather()
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .coordinateSpace(name: "pullToRefresh")
        .task {
            await viewModel.loadWeather()
        }
    }
}

struct ErrorView: View {
    let error: String
    let retyAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundStyle(.orange)
                .padding()
            
            Text("Couldn't load weather")
                .font(.title2)
                .foregroundStyle(.white)
            
            Text(error)
                .font(.body)
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Try Again!", action: retyAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
