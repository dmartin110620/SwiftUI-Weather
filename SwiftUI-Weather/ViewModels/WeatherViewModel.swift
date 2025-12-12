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
    @Published var hourlyForecast: [HourlyForecast] = []
    @Published var dailyForecast: [DailyWeather] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isNight: Bool = false
    @Published var currentTime: String = ""
    
    var currentCity: City
    private let weatherService = WeatherService()
    private var currentTimezone: String = "UTC"
    private var currentTask: Task<Void, Never>?
    
    init(city: City = DefaultCities.cities[0]) {
        self.currentCity = city
    }
    
    // MARK: - Public Methods
    
    /// Load weather for current city
    func loadWeather() async {
        currentTask?.cancel()
        
        currentTask = Task {
            await performLoadWeather()
        }
        await currentTask?.value
    }
    
    /// Load weather for a different city
    func loadWeather(for city: City) async {
        self.currentCity = city
        await loadWeather()
    }
    
    /// Manual day/night toggle
//    func toggleDayNight() {
//        isNight.toggle()
//        updateIconsForCurrentDayNight()
//    }
    
    /// Cancel any ongoing weather loading
    func cancelLoading() {
        currentTask?.cancel()
    }
    
    // MARK: - Private Methods
    
    private func performLoadWeather() async {
        // Only show loading if we have no existing data
        let shouldShowLoading = currentWeather == nil
        
        if shouldShowLoading {
            isLoading = true
        }
        errorMessage = nil
        
        do {
            let response = try await weatherService.getWeather(for: currentCity)
            
            // Check if task was cancelled
            try Task.checkCancellation()
            
            await updateWeatherData(from: response)
        } catch is CancellationError {
            print("Weather loading was cancelled - ignoring")
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            print("URL request was cancelled - ignoring")
            return
        } catch {
            errorMessage = "Failed to load weather: \(error.localizedDescription)"
            print("Weather API error:", error)
            await loadMockData()
        }
        
        if shouldShowLoading {
            isLoading = false
        }
    }
    
    private func updateWeatherData(from response: WeatherResponse) async {
        // Store timezone for this city
        self.currentTimezone = response.timezone
        
        // SIMPLIFIED: Use API's is_day directly
        self.isNight = TimeHelper.isNightTime(isDay: response.current.isDay)
        
        // Get current time in city's timezone
        self.currentTime = TimeHelper.getCurrentTimeInTimezone(response.timezone)
        
        // Update current weather
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
        
        // Update hourly forecast (if available)
        if let hourly = response.hourly {
            hourlyForecast = processHourlyData(
                hourly: hourly,
                timezone: response.timezone
            )
        }
        
        // Update daily forecast
        dailyForecast = []
        for i in 0..<min(response.daily.time.count, 10) {
            let dateString = response.daily.time[i]
            let dayName = TimeHelper.getDayName(from: dateString, timezone: response.timezone)
            
            let weather = DailyWeather(
                dayOfWeek: dayName,
                imageName: WeatherCodeMapper.getDaySFSymbol(for: response.daily.weatherCode[i]),
                temperature: Int(response.daily.temperatureMax[i].rounded()),
                highTemp: Int(response.daily.temperatureMax[i].rounded()),
                lowTemp: Int(response.daily.temperatureMin[i].rounded()),
                weatherCode: response.daily.weatherCode[i],
                timezone: response.timezone
            )
            dailyForecast.append(weather)
        }
    }
    
    private func processHourlyData(hourly: HourlyWeather, timezone: String) -> [HourlyForecast] {
        var forecasts: [HourlyForecast] = []
        
        // Process next 24 hours of data
        for i in 0..<min(hourly.time.count, 24) {
            let isDayHour = TimeHelper.isDayTime(for: hourly.time[i], timezone: timezone)
            
            // Make sure we have valid data (non-nil)
            let precipitation = hourly.precipitation?[i] ?? 0.0
            let humidity = hourly.humidity?[i] ?? 0
            let windSpeed = hourly.windSpeed?[i] ?? 0.0
            
            let imageName = WeatherCodeMapper.getSFSymbol(
                        for: hourly.weatherCode[i],
                        isNight: !isDayHour
                    )
            
            let forecast = HourlyForecast(
                time: hourly.time[i],
                hour: TimeHelper.extractHour(from: hourly.time[i], timezone: timezone),
                hour24: TimeHelper.extractHour24(from: hourly.time[i], timezone: timezone),
                imageName: imageName,
                temperature: Int(hourly.temperature[i]),
                weatherCode: hourly.weatherCode[i],
                precipitation: precipitation,
                humidity: humidity,
                windSpeed: Int(windSpeed),
                isDay: isDayHour,
                timezone: timezone
            )
            forecasts.append(forecast)
        }
        
        // Return only next 12 hours
        return TimeHelper.getNextNHours(from: forecasts)
    }
    
    private func updateIconsForCurrentDayNight() {
        if let current = currentWeather {
            currentWeather = DailyWeather(
                dayOfWeek: current.dayOfWeek,
                imageName: WeatherCodeMapper.getSFSymbol(
                    for: current.weatherCode,
                    isNight: isNight
                ),
                temperature: current.temperature,
                highTemp: current.highTemp,
                lowTemp: current.lowTemp,
                weatherCode: current.weatherCode,
                timezone: current.timezone
            )
        }
    }
    
    private func loadMockData() async {
        dailyForecast = MockData.dayWeeklyForecast
        hourlyForecast = MockData.hourlyForecast
        
        currentWeather = DailyWeather(
            dayOfWeek: "Today",
            imageName: "cloud.sun.fill",
            temperature: 76,
            weatherCode: 2,
            timezone: "America/New_York"
        )
        
        let hour = Calendar.current.component(.hour, from: Date())
        self.isNight = hour < 6 || hour > 18
        self.currentTime = TimeHelper.getCurrentTimeInTimezone("America/New_York")
    }
}
