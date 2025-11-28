//
//  WeatherService.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//

import Foundation

class WeatherService {
    private let baseURL = "https://api.open-meteo.com/v1/forecast"
    
    func getWeather(for city: String) async throws -> WeatherResponse {
        let coordinates = getCoordinates(for: city)
        let urlString = "\(baseURL)?latitude=\(coordinates.lat)&longitude=\(coordinates.lon)&current=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        print("Fetching from: \(urlString)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
        return weatherResponse
    }
    
    private func getCoordinates(for city: String) -> (lat: Double, lon: Double) {
        switch city.lowercased() {
            
        case "san francisco":
            return (lat: 37.7749, lon: -122.4194)
            
        case "los angeles":
            return (lat: 34.0522, lon: -118.2437)
            
        case "new york":
            return (lat: 40.7128, lon: -74.0060)
            
        case "bogota":
            return (lat: 4.6097, lon: -74.0817)
            
        default:
            return (40.7128, -74.0060)
        }
    }
}

