//
//  WeatherResponse.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//

import Foundation

// Top-level response from Open-Meteo
struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let timezoneAbbreviation: String
    let utcOffsetSeconds: Int
    let hourly: HourlyWeather?
    let current: CurrentWeather
    let daily: DailyForecast

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case utcOffsetSeconds = "utc_offset_seconds"
        case current, hourly, daily
    }
}

// Current weather block
struct CurrentWeather: Codable {
    let time: String
    let temperature: Double
    let weatherCode: Int
    let isDay: Int

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case weatherCode = "weather_code"
        case isDay = "is_day"
    }
}

// Daily forecast block
struct DailyForecast: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperatureMax: [Double]
    let temperatureMin: [Double]
    let sunrise: [String]?
    let sunset: [String]?

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case sunrise, sunset
    }
}

// Hourly forecast block

struct HourlyWeather: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperature: [Double]
    let precipitation: [Double]?
    let windSpeed: [Double]?
    let humidity: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature = "temperature_2m"
        case precipitation = "precipitation"
        case windSpeed = "wind_speed_10m"
        case humidity = "relative_humidity_2m"
        
    }
}
