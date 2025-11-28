//
//  WeatherViewModel.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/27/25.
//

import SwiftUI
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var currentWeather: DailyWeather?
    @Published var forecast: [DailyWeather] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var location: String = "Bogota"
    
    private let weatherService = WeatherService()
    
    func loadWeather(for city: String? = nil) async {
        if let city = city {
            location = city
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await weatherService.getWeather(for: location)
            await updateWeatherData(from: response)
        } catch {
            errorMessage = "Failed to load weather: \(error.localizedDescription)"
            
            await loadMockData()
        }
        
        isLoading = false
        
    }
    
    private func updateWeatherData(from response: WeatherResponse) async {
        currentWeather = DailyWeather(
            dayOfWeek: "Today",
            imageName: WeatherCodeMapper.getSFSymbol(for: response.current.weatherCode),
            temperature: Int(response.current.temperature.rounded()),
            highTemp: nil,
            lowTemp: nil
        )
        
        forecast = []
        for i in 0..<min(response.daily.time.count, 5) {
            let dateString = response.daily.time[i]
            let dayName = getDayName(from: dateString)
            
            let weather = DailyWeather(
                dayOfWeek: dayName,
                imageName: WeatherCodeMapper.getSFSymbol(for: response.daily.weatherCode[i]),
                temperature: Int(response.daily.temperatureMax[i].rounded()),
                highTemp: Int(response.daily.temperatureMax[i].rounded()),
                lowTemp: Int(response.daily.temperatureMin[i].rounded())
            )
            forecast.append(weather)
        }
    }
    
    private func getDayName(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: dateString) else {
            return "Unknown"
        }
        
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).uppercased()
    }
    
    private func loadMockData() async {
        forecast = MockData.dayWeeklyForecast
        currentWeather = DailyWeather(
            dayOfWeek: "Today",
            imageName: "cloud.sun.fill",
            temperature: 76
        )
    }
}
