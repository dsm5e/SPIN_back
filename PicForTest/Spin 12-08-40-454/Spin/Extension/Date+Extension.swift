//
//  Date+Extension.swift
//  Spin
//
//  Created by dsm 5e on 15.06.2023.
//

import Foundation

extension Date {
//2
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: self)
    }
}


extension String {
//1
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)
    }
//3
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
    
    func daysSinceCreatedAt() -> String? {
        guard let date = self.convertToDate() else { return "N/A" }
        let currentDate = Date()
        let intervalInSeconds = currentDate.timeIntervalSince(date)
        let daysSinceCreatedAt = Int(intervalInSeconds / (24 * 3600))
        return "\(daysSinceCreatedAt)"
    }
}
