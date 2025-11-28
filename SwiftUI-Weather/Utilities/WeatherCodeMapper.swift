//
//  WeatherCodeMapper.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/27/25.
//

import Foundation

class WeatherCodeMapper {
    static func getSFSymbol(for code: Int) -> String {
        switch code {
        case 0: return "sun.max.fill" // Clear sky
        case 1, 2: return "cloud.sun.fill" // Mainly clear, partly cloudy
        case 3: return "cloud.fill" // Overcast
        case 45, 48: return "cloud.fog.fill" // Fog
        case 51, 53, 55: return "cloud.drizzle.fill" // Drizzle
        case 56, 57: return "cloud.sleet.fill" // Freezing drizzle
        case 61, 63, 65: return "cloud.rain.fill" // Rain
        case 66, 67: return "cloud.snow.fill" // Freezing rain
        case 71, 73, 75: return "snow.fill" // Snow fall
        case 77: return "cloud.hail.fill" // Snow grains
        case 80, 81, 82: return "cloud.heavyrain.fill" // Rain showers
        case 85, 86: return "cloud.snow.fill" // Snow showers
        case 95: return "cloud.bolt.fill" // Thunderstorm
        case 96, 99: return "cloud.bolt.rain.fill" // Thunderstorm with hail
        default: return "questionmark" // Unknown
        }
    }
    
    static func getDescription(for code: Int) -> String {
        switch code {
        case 0: return "Clear sky"
        case 1: return "Mainly clear"
        case 2: return "Partly cloudy"
        case 3: return "Overcast"
        case 45, 48: return "Fog"
        case 51, 53, 55: return "Drizzle"
        case 61, 63, 65: return "Rain"
        case 71, 73, 75: return "Snow"
        case 95: return "Thunderstorm"
        default: return "Unknown"
        }
    }
}
