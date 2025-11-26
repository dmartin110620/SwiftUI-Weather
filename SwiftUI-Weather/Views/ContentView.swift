//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    private var forecastData: [DailyWeather] {
        isNight ? MockData.nightWeeklyForecast : MockData.dayWeeklyForecast
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "Manhattan, NY")
                
                MainWeatherStatusView (
                    imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                    temperature: isNight ? 68 : 76
                )
                
                HStack(spacing:25){
                    ForEach(forecastData) { day in
                        WeatherDayView(
                            dayOfWeek: day.dayOfWeek,
                            imageName: day.imageName,
                            temperature: day.temperature
                        )
                    }
                }
                .padding(15)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time",
                                  textColor: .black,
                                  backgroundColor: (Color.white.opacity(0.7)))
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
