//
//  APIRequestValidator.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation

enum APIRequestValidator {
    private static let lastFetchKey = "lastAPIFetchDate"

    static func shouldFetchData() -> Bool {
        guard let lastDate = UserDefaults.standard.object(forKey: lastFetchKey) as? Date else {
            return true
        }
        return !Calendar.current.isDateInToday(lastDate)
    }

    static func markAPICallDone() {
        UserDefaults.standard.set(Date(), forKey: lastFetchKey)
    }
}
