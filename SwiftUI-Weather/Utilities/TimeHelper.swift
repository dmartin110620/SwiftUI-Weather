//
//  TimeHelper.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/30/25.
//

import Foundation

class TimeHelper {
    static func isNightTime(in timezone: String, sunrise: [String]?, sunset: [String]?) -> Bool {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timezone) ?? TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

        let now = Date()

        if let sunriseTimes = sunrise,
           let sunsetTimes = sunset,
           let firstSunrise = sunriseTimes.first,
           let firstSunset = sunsetTimes.first,
           !firstSunrise.isEmpty,
           !firstSunset.isEmpty,
           let sunriseTime = formatter.date(from: firstSunrise),
           let sunsetTime = formatter.date(from: firstSunset) {

            return now < sunriseTime || now > sunsetTime
        }

        // Fallback to hour-based heuristic if sunrise/sunset not available or unparsable
        formatter.dateFormat = "HH"
        let hourString = formatter.string(from: now)
        guard let hour = Int(hourString) else { return false }

        return hour <= 6 || hour >= 19
    }

    static func getCurrentTimeInTimezone(_ timezone: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timezone) ?? TimeZone.current
        formatter.dateFormat = "HH:mm"

        return formatter.string(from: Date())
    }

    static func convertToLocalTime(_ timeString: String, timezone: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

        guard let date = formatter.date(from: timeString) else { return nil }

        // Return the same absolute Date; the consumer should format using desired timezone
        // If needed to interpret the string as being in UTC and then view in target timezone,
        // create a Calendar-based conversion when formatting rather than altering the Date.
        return date
    }
}
