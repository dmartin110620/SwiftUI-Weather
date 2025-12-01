//
//  WeatherService.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//

import Foundation

class WeatherService {
    private let baseURL = "https://api.open-meteo.com/v1/forecast"
    
    func getWeather(for city: City) async throws -> WeatherResponse {
        let urlString = "\(baseURL)?latitude=\(city.latitude)&longitude=\(city.longitude)&current=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto"
        // Check API, params sunset,sunrise. Future implementation
        
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
}
