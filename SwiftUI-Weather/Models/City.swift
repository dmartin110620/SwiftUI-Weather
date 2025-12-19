//
//  City.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/29/25.
//

import Foundation

struct City: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    var displayName: String {
        "\(name), \(country)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
}
