//
//  WeatherButton.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/25/25.
//

import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(15)
            .font(.system(size: 20, weight: .bold, design: .default))
    }
}
