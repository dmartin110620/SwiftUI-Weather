//
//  DailyForecastView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 12/5/25.
//
import SwiftUI

struct DailyForecastView: View {
    let dailyForecast: [DailyWeather]
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.white)
                Text("Day Forecast")
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundStyle(.white.opacity(0.9))
                Spacer()
                Text("Next 10 days")
                    .font(.system(size: 12, weight: .regular, design: .default))
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
                        ForEach(dailyForecast) { dayWeather in
                            WeatherDayView(
                                dayOfWeek: dayWeather.dayOfWeek,
                                imageName: dayWeather.imageName,
                                temperature: dayWeather.temperature
                            )
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
        .padding(.vertical, 20)
        .glassEffect(.clear, in: .rect(cornerRadius: 20))
        .padding(.horizontal)
    }
}
