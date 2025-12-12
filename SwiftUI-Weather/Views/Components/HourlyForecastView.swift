//
//  Untitled.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 12/4/25.
//

import SwiftUI

struct HourlyForecastView: View {
    let hourlyForecasts: [HourlyForecast]
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "clock")
                    .foregroundStyle(.white)
                Text("Hourly Forecast")
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundStyle(.white.opacity(0.9))
                Spacer()
                Text("Next 12 hours")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.horizontal, 15)
            
            Divider()
                .background(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
            
            if isExpanded {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(hourlyForecasts.prefix(12)) { hour in
                            HourlyForecastCell(forecast: hour)
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
        .padding(.vertical, 20)
        .glassEffect(.clear, in: .rect(cornerRadius: 20))
        .padding(.horizontal)
        Spacer()
    }
}

struct HourlyForecastCell: View {
    let forecast: HourlyForecast
    
    var body: some View {
        VStack(spacing: 20) {
            Text(forecast.hour)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
            Image(systemName: forecast.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
            Text("\(forecast.temperature)°")
                .font(.system(size: 22, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .padding(.horizontal,10)
    }
}
