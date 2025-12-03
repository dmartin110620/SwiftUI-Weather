//
//  MainWeatherStatusView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/26/25.
//
import SwiftUI

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    var highTemp: Int
    var lowTemp: Int
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 160)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
            HStack(spacing: 10) {
                Text("H:\(highTemp)°")
                    .font(.system(size: 18, weight: .light))
                    .foregroundStyle(.white)
                Text("L:\(lowTemp)°")
                    .font(.system(size: 18, weight: .light))
                    .foregroundStyle(.white)
            }
        }
        .padding(.bottom, 30)
    }
}
