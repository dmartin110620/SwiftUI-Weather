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
    @Published var isNight: Bool = false
    @Published var currentTime: String = ""
    
    var currentCity: City
    
    private let weatherService = WeatherService()
    private var currentTimezone: String = "UTC"
    
    init(city: City = DefaultCities.cities[0]) {
        self.currentCity = city
    }
    
//    Load for current city
    func loadWeather(for city: String? = nil) async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await weatherService.getWeather(for: currentCity)
            await updateWeatherData(from: response)
        } catch {
            errorMessage = "Failed to load weather: \(error.localizedDescription)"
            print("Weather API error:", error)
            await loadMockData()
        }
        
        isLoading = false
    }
    
//    Load for different city
    func loadWeather (for city: City) async {
        self.currentCity = city
        await loadWeather()
    }
    
    private func updateWeatherData(from response: WeatherResponse) async {
        self.currentTimezone = response.timezone
        
        self.isNight = TimeHelper.isNightTime(
            in: response.timezone,
            sunrise: response.daily.sunrise,
            sunset: response.daily.sunset
        )
        
        self.currentTime = TimeHelper.getCurrentTimeInTimezone(response.timezone)
        
        currentWeather = DailyWeather(
            dayOfWeek: "Today",
            imageName: WeatherCodeMapper.getSFSymbol(
                for: response.current.weatherCode,
                isNight: isNight
            ),
            temperature: Int(response.current.temperature.rounded()),
            highTemp: Int(response.daily.temperatureMax[0].rounded()),
            lowTemp: Int(response.daily.temperatureMin[0].rounded()),
            weatherCode: response.current.weatherCode,
            timezone: response.timezone
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
                lowTemp: Int(response.daily.temperatureMin[i].rounded()),
                weatherCode: response.daily.weatherCode[i],
                timezone: response.timezone
            )
            forecast.append(weather)
        }
    }
    
    func toggleDayNight() {
        isNight.toggle()
        updateIconsForCurrentDayNight()
    }
    
    private func updateIconsForCurrentDayNight() {
        if let current = currentWeather {
            currentWeather = DailyWeather(
                dayOfWeek: current.dayOfWeek,
                imageName: WeatherCodeMapper.getSFSymbol(for: current.weatherCode, isNight: isNight),
                temperature: current.temperature,
                highTemp: current.highTemp,
                lowTemp: current.lowTemp,
                weatherCode: current.weatherCode,
                timezone: current.timezone
            )
        }
    }
    
    private func isCurrentlyNightTime() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour > 18 // Simple: night between 6 PM and 6 AM
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
            temperature: 76,
            weatherCode: 2,
            timezone: "America/New_York"
        )
    }
}
