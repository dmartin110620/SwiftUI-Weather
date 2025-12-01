//
//  DailyWeather.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//

import Foundation

struct DailyWeather: Identifiable {
    
    let id = UUID()
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
    let highTemp: Int?
    let lowTemp: Int?
    let weatherCode: Int
    let timezone: String
    
    init(dayOfWeek: String, imageName: String, temperature: Int, highTemp: Int? = nil, lowTemp: Int? = nil, weatherCode: Int, timezone: String) {
        self.dayOfWeek = dayOfWeek
        self.imageName = imageName
        self.temperature = temperature
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.weatherCode = weatherCode
        self.timezone = timezone
    }
}
