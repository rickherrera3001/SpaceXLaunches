//
//  APIRequestValidator.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 01/06/25.
//

import Foundation

struct APIRequestValidator {
    
    private static let lastFetchKey = "LastAPIFetchDate"

    static func shouldFetchData() -> Bool {
        let defaults = UserDefaults.standard

        if let lastFetch = defaults.object(forKey: lastFetchKey) as? Date {
            return !Calendar.current.isDateInToday(lastFetch)
        }
        
        return true
    }

    static func markAPICallDone() {
        let defaults = UserDefaults.standard
        defaults.set(Date(), forKey: lastFetchKey)
    }
}
