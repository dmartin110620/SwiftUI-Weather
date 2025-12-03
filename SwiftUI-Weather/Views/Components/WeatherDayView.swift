//
//  WeatherDayView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//
import SwiftUI

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing:20) {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("\(temperature)°")
                .font(.system(size: 22, weight: .medium, design: .default))
                .foregroundStyle(.white)
        }
    }
}
