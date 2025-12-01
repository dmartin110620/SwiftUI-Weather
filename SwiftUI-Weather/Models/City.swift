//
//  City.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/29/25.
//

import Foundation

struct City: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    var displayName: String {
        "\(name), \(country)"
    }
    
    init(id: UUID = UUID(), name: String, country: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
}
