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
    @State private var showHourlyForecast = true
    @State private var showDailyForecast = true
    
    init(city: City) {
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
                VStack(spacing: 20) {
                    // City header
                    VStack(spacing: 5) {
                        CityTextView(cityName: city.displayName)
                    }
                    // Loading state
                    if viewModel.isLoading && viewModel.currentWeather == nil {
                        VStack {
                            Spacer()
                            ProgressView("Loading forecast...")
                                .scaleEffect(1.2)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .frame(height: 200)
                    }
                    
                    // Current weather
                    if let currentWeather = viewModel.currentWeather {
                        MainWeatherStatusView(
                            imageName: currentWeather.imageName,
                            temperature: currentWeather.temperature,
                            highTemp: currentWeather.highTemp ?? currentWeather.temperature,
                            lowTemp: currentWeather.lowTemp ?? currentWeather.temperature
                        )
                        
                        // Hourly forecast
                        HourlyForecastView(
                            hourlyForecasts: viewModel.hourlyForecast,
                            isExpanded: $showHourlyForecast
                        )
                        
                        // Daily forecast
                        DailyForecastView(
                                    dailyForecast: viewModel.dailyForecast,
                                    isExpanded: $showDailyForecast
                                )
                        
                    } else if let error = viewModel.errorMessage {
                        // Error state
                        VStack(spacing: 15) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: 50))
                                .foregroundStyle(.orange)
                            
                            Text("Couldn't load weather")
                                .font(.title2)
                                .foregroundStyle(.white)
                            
                            Text(error)
                                .font(.body)
                                .foregroundStyle(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button("Try Again") {
                                Task {
                                    await viewModel.loadWeather()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                }
                .padding(.bottom, 30)
            }
        }
        .coordinateSpace(name: "pullToRefresh")
        .task {
            await viewModel.loadWeather()
        }
    }
}
