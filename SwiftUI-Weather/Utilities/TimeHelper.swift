//
//  TimeHelper.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 11/30/25.
//

import Foundation

class TimeHelper {
    
    // MARK: - Simple Day/Night Detection (using API's is_day)
    
    /// Convert Open-Meteo's is_day (1 or 0) to Boolean
    static func isNightTime(isDay: Int) -> Bool {
        return isDay == 0
    }
    
    // MARK: - Time Display Helpers
    
    static func getCurrentTimeInTimezone(_ timezone: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timezone) ?? TimeZone.current
        formatter.dateFormat = "h:mm a"  // "2:30 PM" format
        return formatter.string(from: Date())
    }
    
    //    static func getCurrentHourInTimezone(_ timezone: String) -> Int {
    //        let formatter = DateFormatter()
    //        formatter.timeZone = TimeZone(identifier: timezone) ?? TimeZone.current
    //        formatter.dateFormat = "HH"
    //        return Int(formatter.string(from: Date())) ?? 12
    //    }
    
    // MARK: - Date Parsing & Formatting
    
    static func extractHour(from timeString: String, timezone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: timeString) else {
            return "N/A"
        }
        
        let hourFormatter = DateFormatter()
        hourFormatter.timeZone = TimeZone(identifier: timezone)
        hourFormatter.dateFormat = "h a"
        return hourFormatter.string(from: date)
    }
    
    static func extractHour24(from timeString: String, timezone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: timeString) else {
            return "N/A"
        }
        
        let hourFormatter = DateFormatter()
        hourFormatter.timeZone = TimeZone(identifier: timezone)
        hourFormatter.dateFormat = "HH:mm"
        return hourFormatter.string(from: date)
    }
    
    static func getDayName(from dateString: String, timezone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = formatter.date(from: dateString) else {
            return "N/A"
        }
        
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).uppercased()
    }
    
    // MARK: - Forecast Filtering
    
    static func getNextNHours(from forecasts: [HourlyForecast], hours: Int = 12) -> [HourlyForecast] {
        let now = Date()
        let calendar = Calendar.current
        
        let filtered = forecasts.filter { forecast in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            if let forecastDate = dateFormatter.date(from: forecast.time) {
                let hoursDifference = calendar.dateComponents([.hour], from: now, to: forecastDate).hour ?? 0
                return hoursDifference >= 0 && hoursDifference < hours
            }
            return false
        }
        
        return Array(filtered.prefix(hours))
    }
    
    // MARK: - Day/Night for Specific Hour (for hourly forecast)
    
    /// Determine if a specific hour is day or night based on typical sunrise/sunset hours
    static func isDayTime(for timeString: String, timezone: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: timeString) else {
            return true
        }
        
        let localFormatter = DateFormatter()
        localFormatter.timeZone = TimeZone(identifier: timezone)
        localFormatter.dateFormat = "HH"
        
        let hourString = localFormatter.string(from: date)
        guard let hour = Int(hourString) else {
            return true
        }
        
        return hour >= 6 && hour < 18
    }
    
    // MARK: - Timezone Utilities
//    
//    static func getTimezoneAbbreviation(for timezone: String) -> String {
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone(identifier: timezone)
//        formatter.dateFormat = "zzz"  // Timezone abbreviation (EST, PST, etc.)
//        return formatter.string(from: Date())
//    }
//    
//    static func isCurrentlyDaylightSavingTime(for timezone: String) -> Bool {
//        guard let tz = TimeZone(identifier: timezone) else {
//            return TimeZone.current.isDaylightSavingTime()
//        }
//        return tz.isDaylightSavingTime()
//    }
    
    // MARK: - sunrise/sunset times
    //    static func formatSunriseSunset(timeString: String, timezone: String) -> String {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    //        formatter.timeZone = TimeZone(abbreviation: "UTC")
    //
    //        guard let date = formatter.date(from: timeString) else {
    //            return "N/A"
    //        }
    //
    //        formatter.timeZone = TimeZone(identifier: timezone)
    //        formatter.dateFormat = "h:mm a"
    //        return formatter.string(from: date)
    //    }
}
