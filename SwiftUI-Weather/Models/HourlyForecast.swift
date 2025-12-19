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
    let precipitation: Double
    let humidity: Int
    let windSpeed: Int
    let isDay: Bool
    let timezone: String
}
