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
    
    var body: some View {
        VStack(spacing: 10) {
                            Image(systemName: imageName)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 180, height: 180)
                            Text("\(temperature)°")
                                .font(.system(size: 70, weight: .medium))
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, 50)
    }
}
