//
//  WeatherCodeMapper.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/27/25.
//

import Foundation

class WeatherCodeMapper {
    
    // For daytime icons
    static func getDaySFSymbol(for code: Int) -> String {
        switch code {
        case 0: return "sun.max.fill"           // Clear sky
        case 1: return "sun.max.fill"           // Mainly clear
        case 2: return "cloud.sun.fill"         // Partly cloudy
        case 3: return "cloud.fill"             // Overcast
        case 45, 48: return "cloud.fog.fill"    // Fog
        case 51, 53, 55: return "cloud.drizzle.fill" // Drizzle
        case 56, 57: return "cloud.sleet.fill"  // Freezing drizzle
        case 61, 63, 65: return "cloud.rain.fill" // Rain
        case 66, 67: return "cloud.snow.fill"   // Freezing rain
        case 71, 73, 75: return "snowflake"     // Snow fall (snowflake is better for snow)
        case 77: return "cloud.hail.fill"       // Snow grains
        case 80, 81, 82: return "cloud.heavyrain.fill" // Rain showers
        case 85, 86: return "cloud.snow.fill"   // Snow showers
        case 95: return "cloud.bolt.fill"       // Thunderstorm
        case 96, 99: return "cloud.bolt.rain.fill" // Thunderstorm with hail
        default: return "questionmark"
        }
    }
    
    // For nighttime icons
    static func getNightSFSymbol(for code: Int) -> String {
        switch code {
        case 0: return "moon.stars.fill"        // Clear sky
        case 1: return "moon.fill"              // Mainly clear
        case 2: return "cloud.moon.fill"        // Partly cloudy
        case 3: return "cloud.fill"             // Overcast (same as day)
        case 45, 48: return "cloud.fog.fill"    // Fog (same as day)
        case 51, 53, 55: return "cloud.drizzle.fill" // Drizzle (same as day)
        case 56, 57: return "cloud.sleet.fill"  // Freezing drizzle (same as day)
        case 61, 63, 65: return "cloud.moon.rain.fill" // Rain at night
        case 66, 67: return "cloud.snow.fill"   // Freezing rain (same as day)
        case 71, 73, 75: return "snowflake"     // Snow fall (same as day)
        case 77: return "cloud.hail.fill"       // Snow grains (same as day)
        case 80, 81, 82: return "cloud.moon.rain.fill" // Rain showers at night
        case 85, 86: return "cloud.snow.fill"   // Snow showers (same as day)
        case 95: return "cloud.bolt.fill"       // Thunderstorm (same as day)
        case 96, 99: return "cloud.bolt.rain.fill" // Thunderstorm with hail (same as day)
        default: return "questionmark"
        }
    }
    
    // Universal method that takes isNight parameter
    static func getSFSymbol(for code: Int, isNight: Bool = false) -> String {
        return isNight ? getNightSFSymbol(for: code) : getDaySFSymbol(for: code)
    }
    
    static func getDescription(for code: Int) -> String {
        switch code {
        case 0: return "Clear sky"
        case 1: return "Mainly clear"
        case 2: return "Partly cloudy"
        case 3: return "Overcast"
        case 45, 48: return "Fog"
        case 51: return "Light drizzle"
        case 53: return "Moderate drizzle"
        case 55: return "Dense drizzle"
        case 61: return "Slight rain"
        case 63: return "Moderate rain"
        case 65: return "Heavy rain"
        case 71: return "Slight snow"
        case 73: return "Moderate snow"
        case 75: return "Heavy snow"
        case 77: return "Snow grains"
        case 80: return "Slight rain showers"
        case 81: return "Moderate rain showers"
        case 82: return "Violent rain showers"
        case 85: return "Slight snow showers"
        case 86: return "Heavy snow showers"
        case 95: return "Thunderstorm"
        case 96: return "Thunderstorm with slight hail"
        case 99: return "Thunderstorm with heavy hail"
        default: return "Unknown"
        }
    }
}
