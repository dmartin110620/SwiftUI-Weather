//
//  HourlyForecast.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 12/4/25.
//

import Foundation

struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let hour: String
    let hour24: String
    let imageName: String
    let temperature: Int
    let weatherCode: Int
    let precipitation: Double?
    let humidity: Int
    let windSpeed: Int?
    let isDay: Bool?
    
    init(
        time: String,
        hour: String,
        hour24: String,
        imageName: String,
        temperature: Int,
        weatherCode: Int,
        precipitation: Double? = nil,
        humidity: Int,
        windSpeed: Int? = nil,
        isDay: Bool? = nil,
        timezone: String
    ) {
        self.time = time
        self.hour = hour
        self.hour24 = hour24
        self.imageName = imageName
        self.temperature = temperature
        self.weatherCode = weatherCode
        self.precipitation = precipitation
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.isDay = isDay
    }
}
