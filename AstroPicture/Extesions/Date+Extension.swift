//
//  Date+Extension.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Foundation

enum DateFormat: String {
    case yyyyMMdd = "yyyy-MM-dd"
}

extension Date {
    /// Date in formatted String
    /// - Parameter format: date format
    /// - Returns: retun formatted date
    func dateString(withFormat format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
