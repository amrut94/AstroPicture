//
//  DateExtensionTests.swift
//  AstroPictureUnitTests
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import XCTest
@testable import AstroPicture

final class DateExtensionTests: XCTestCase {
    
    func testDateStringWithyyyyMMddFormat() {
        let date = Date(timeIntervalSince1970: 0) // January 1, 1970
        let expectedDateString = "1970-01-01"
        let formattedDateString = date.dateString(withFormat: .yyyyMMdd)
        XCTAssertEqual(formattedDateString, expectedDateString, "The date string should be '1970-01-01'")
    }
    
    func testDateStringWithDifferentDate() {
        let dateComponents = DateComponents(year: 2024, month: 5, day: 26)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let expectedDateString = "2024-05-26"
        let formattedDateString = date.dateString(withFormat: .yyyyMMdd)
        XCTAssertEqual(formattedDateString, expectedDateString, "The date string should be '2024-05-26'")
    }
}
