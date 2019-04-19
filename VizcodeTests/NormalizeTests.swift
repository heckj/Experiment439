//
//  NormalizeTests.swift
//  VizcodeTests
//
//  Created by Joseph Heck on 4/19/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import XCTest

class NormalizeTests: XCTestCase {
    func testNormalizeMid() {
        let resultValue = normalize(x: 150.0, domain: 100.0..<200.0)
        XCTAssertFalse(resultValue.isNaN)
        XCTAssertEqual(resultValue, 0.5, accuracy: 0.01)
    }

    func testNormalizeLower() {
        let resultValue = normalize(x: 100.0, domain: 100.0..<200.0)
        XCTAssertFalse(resultValue.isNaN)
        XCTAssertEqual(resultValue, 0.0, accuracy: 0.01)
    }

    func testNormalizeUpper() {
        let resultValue = normalize(x: 199.9, domain: 100.0..<200.0)
        XCTAssertFalse(resultValue.isNaN)
        XCTAssertEqual(resultValue, 1.0, accuracy: 0.01)
    }

    func testNormalizeUpperLimit() {
        let resultValue = normalize(x: 200.0, domain: 100.0..<200.0)
        XCTAssertTrue(resultValue.isNaN)
        // you might expect this to be 1.0, but since we're using a Range vs. ClosedRange the very upper
        // value is verbotten...
    }

    func testNormalizeAbove() {
        let resultValue = normalize(x: 201.0, domain: 100.0..<200.0)
        XCTAssertTrue(resultValue.isNaN)
//        XCTAssertEqual(resultValue, 1.0, accuracy: 0.01)
    }
}
