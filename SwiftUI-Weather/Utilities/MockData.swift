//
//  MockData.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//

import Foundation

struct MockData {
    static let dayWeeklyForecast = [
        DailyWeather(dayOfWeek: "TUE",
                     imageName: "cloud.sun.fill",
                     temperature: 76),
        
        DailyWeather(dayOfWeek: "WED",
                     imageName: "sun.max.fill",
                     temperature: 89),
        
        DailyWeather(dayOfWeek: "THU",
                     imageName: "cloud.drizzle.fill",
                     temperature: 72),
        
        DailyWeather(dayOfWeek: "FRI",
                     imageName: "tornado",
                     temperature: 70),
        
        DailyWeather(dayOfWeek: "SAT",
                     imageName: "cloud.sun.rain.fill",
                     temperature: 73)
    ]
    
    static let nightWeeklyForecast = [
        DailyWeather(dayOfWeek: "TUE",
                     imageName: "moon.stars.fill",
                     temperature: 68),
        
        DailyWeather(dayOfWeek: "WED",
                     imageName: "moon.fill",
                     temperature: 65),
        
        DailyWeather(dayOfWeek: "THU",
                     imageName: "cloud.moon.fill",
                     temperature: 62),
        
        DailyWeather(dayOfWeek: "FRI",
                     imageName: "wind.snow",
                     temperature: 58),
        
        DailyWeather(dayOfWeek: "SAT",
                     imageName: "cloud.moon.rain.fill",
                     temperature: 60)
    ]
}
