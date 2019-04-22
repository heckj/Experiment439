//
//  LinearScaleTests.swift
//  VizcodeTests
//
//  Created by Joseph Heck on 4/19/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import XCTest

class LinearScaleTests: XCTestCase {
    var inputRange: ClosedRange<Double>?
    var outputRange: ClosedRange<Double>?
    var scaleUnderTest: LinearScale?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        inputRange = 0...100.0
        outputRange = 0...50.0
        scaleUnderTest = LinearScale(domain: inputRange!, range: outputRange!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: - initializer tests

    func testLinearScaleInitializer() {
        XCTAssertNotNil(scaleUnderTest)
        XCTAssertFalse(scaleUnderTest!.isClamped)
        XCTAssertEqual(inputRange, scaleUnderTest?.domain, "domain should match input range")
        XCTAssertEqual(outputRange, scaleUnderTest?.range, "range should match output range")
    }

    // MARK: - scale tests

    func testLinearScale_scaleBelow() {
        let resultValue = scaleUnderTest?.scale(-10.0)
        XCTAssertTrue(resultValue!.isNaN)
    }

    func testLinearScale_scaleLower() {
        let resultValue = scaleUnderTest?.scale(0.0)
        XCTAssertEqual(0.0, resultValue!, accuracy: 0.1)
    }

    func testLinearScale_scaleMid() {
        let resultValue = scaleUnderTest?.scale(50.0)
        XCTAssertEqual(25.0, resultValue!, accuracy: 0.1)
    }

    func testLinearScale_scaleUpper() {
        let resultValue = scaleUnderTest?.scale(100.0)
        XCTAssertEqual(50.0, resultValue!, accuracy: 0.1)
    }

    func testLinearScale_scaleAbove() {
        let resultValue = scaleUnderTest?.scale(110.0)
        XCTAssertTrue(resultValue!.isNaN)
    }

    // MARK: - invert tests

    func testLinearScale_invertBelow() {
        let resultValue = scaleUnderTest?.invert(-10.0)
        XCTAssertTrue(resultValue!.isNaN)
    }

    func testLinearScale_invertLower() {
        let resultValue = scaleUnderTest?.invert(0.0)
        XCTAssertEqual(0.0, resultValue!, accuracy: 0.1)
    }

    func testLinearScale_invertMid() {
        let resultValue = scaleUnderTest?.invert(25.0)
        XCTAssertEqual(50.0, resultValue!, accuracy: 0.1)
    }

    func testLinearScale_invertUpper() {
        let resultValue = scaleUnderTest?.invert(50.0)
        XCTAssertEqual(100.0, resultValue!, accuracy: 0.1)
    }

    func testLinearScale_invertAbove() {
        let resultValue = scaleUnderTest?.invert(60.0)
        XCTAssertTrue(resultValue!.isNaN)
    }

    // MARK: - tick tests

    func testTicks_default() {
        let results = scaleUnderTest?.ticks()
        XCTAssertEqual(results?.count, 11)
        // print(results as Any)
        XCTAssertEqual([0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0], results!)
    }

    func testTicks_small() {
        let results = scaleUnderTest?.ticks(count: 2)
        XCTAssertEqual(results?.count, 3)
        // print(results as Any)
        XCTAssertEqual([0.0, 50.0, 100.0], results!)
    }
}
