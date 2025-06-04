//
//  DateFormatter+Extensions.swift .swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation

extension String {
    func formattedAsSpanishDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: self) ??
                         ISO8601DateFormatter().date(from: self) else {
            return self
        }

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.locale = Locale(identifier: "es_ES")
        weekdayFormatter.dateFormat = "EEEE"

        let monthFormatter = DateFormatter()
        monthFormatter.locale = Locale(identifier: "es_ES")
        monthFormatter.dateFormat = "LLL"

        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        let weekday = weekdayFormatter.string(from: date).capitalized
        let month = monthFormatter.string(from: date).lowercased()
        let day = dayFormatter.string(from: date)
        let year = yearFormatter.string(from: date)

        return "\(weekday), \(month) \(day), \(year)"
    }
}

