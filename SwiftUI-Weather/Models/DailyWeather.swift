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
    
    init(dayOfWeek: String, imageName: String, temperature: Int) {
        self.dayOfWeek = dayOfWeek
        self.imageName = imageName
        self.temperature = temperature
    }
}
