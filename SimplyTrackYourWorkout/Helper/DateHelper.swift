//
//  DateHelper.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//

import Foundation

class DateHelper {
    static let shared = DateHelper()

    private let formatter: DateFormatter

    private init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }

    func string(from date: Date) -> String {
        return formatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return formatter.date(from: string)
    }
}
