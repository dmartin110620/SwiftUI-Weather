//
//  MockData.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//

import Foundation

struct MockData {
    static let mockDays = ["SUN", "MON", "TUE", "WED", "THU"]
    
    static let hourlyForecast = [
        HourlyForecast(
            time: "2025-12-01T14:00",
            hour: "14:00",
            hour24: "2 PM",
            imageName: "cloud.sun.fill",
            temperature: 76,
            weatherCode: 2,
            precipitation: 0,
            humidity: 65,
            windSpeed: 8,
            isDay: true,
            timezone: ""
        )
    ]
    
    static let dayWeeklyForecast: [DailyWeather] = mockDays.map { day in
        DailyWeather(
            dayOfWeek: day,
            imageName: "cloud.sun.fill",
            temperature: 76,
            highTemp: 90,
            lowTemp: 70,
            weatherCode: 2,
            timezone: ""
        )
    }
    
    static let nightWeeklyForecast: [DailyWeather] = mockDays.map { day in
        DailyWeather(
            dayOfWeek: day,
            imageName: "moon.stars.fill",
            temperature: 68,
            highTemp: 90,
            lowTemp: 70,
            weatherCode: 0,
            timezone: ""
        )
    }
    
    // Simple fallback forecast
//    static let weeklyForecast = dayWeeklyForecast
}
