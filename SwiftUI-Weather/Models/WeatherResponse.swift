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
    let current: CurrentWeatherResponse
    let daily: DailyForecastResponse

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case utcOffsetSeconds = "utc_offset_seconds"
        case current, daily
    }
}

// Current weather block
struct CurrentWeatherResponse: Codable {
    let time: String
    let temperature: Double
    let weatherCode: Int
    let isDay: Int?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case weatherCode = "weather_code"
        case isDay = "is_day"
    }
}

// Daily forecast block
struct DailyForecastResponse: Codable {
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
