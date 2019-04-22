//
//  InterpolateTests.swift
//  VizcodeTests
//
//  Created by Joseph Heck on 4/19/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import XCTest

class InterpolateTests: XCTestCase {
    func testInterpolateMid() {
        let resultValue = interpolate(0.5, range: 100.0...200.0)
        XCTAssertEqual(resultValue, 150.0, accuracy: 0.1)
    }

    func testInterpolateLower() {
        let resultValue = interpolate(0, range: 100.0...200.0)
        XCTAssertEqual(resultValue, 100.0, accuracy: 0.1)
    }

    func testInterpolateUpper() {
        let resultValue = interpolate(1, range: 100.0...200.0)
        XCTAssertEqual(resultValue, 200.0, accuracy: 0.1)
    }
}
