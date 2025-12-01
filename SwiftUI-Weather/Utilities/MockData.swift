//
//  MockData.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//

import Foundation

struct MockData {
    static let dayWeeklyForecast = [
        DailyWeather(
            dayOfWeek: "TUE",
            imageName: "cloud.sun.fill",
            temperature: 76,
            weatherCode: 2,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "WED",
            imageName: "sun.max.fill",
            temperature: 89,
            weatherCode: 0,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "THU",
            imageName: "cloud.drizzle.fill",
            temperature: 72,
            weatherCode: 53,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "FRI",
            imageName: "tornado",
            temperature: 70,
            weatherCode: 95,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "SAT",
            imageName: "cloud.sun.rain.fill",
            temperature: 73,
            weatherCode: 80,
            timezone: "America/New_York"
        )
    ]
    
    static let nightWeeklyForecast = [
        DailyWeather(
            dayOfWeek: "TUE",
            imageName: "moon.stars.fill",
            temperature: 68,
            weatherCode: 0,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "WED",
            imageName: "moon.fill",
            temperature: 65,
            weatherCode: 1,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "THU",
            imageName: "cloud.moon.fill",
            temperature: 62,
            weatherCode: 2,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "FRI",
            imageName: "wind.snow",
            temperature: 58,
            weatherCode: 71,
            timezone: "America/New_York"
        ),
        
        DailyWeather(
            dayOfWeek: "SAT",
            imageName: "cloud.moon.rain.fill",
            temperature: 60,
            weatherCode: 63,
            timezone: "America/New_York"
        )
    ]
    
    // Simple fallback forecast
//    static let weeklyForecast = dayWeeklyForecast
}
