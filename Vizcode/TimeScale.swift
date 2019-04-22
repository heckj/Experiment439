//
//  TimeScale.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/22/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation

// https://github.com/d3/d3-scale/blob/master/src/time.js

/// Time scales are similar to linear scales, but use Dates instead of numbers and range is
/// implied/identify from the domain

// import { scaleTime } from 'd3-scale';
// const time = scaleTime()
//    .domain([new Date('1910-1-1'), (new Date('1920-1-1'))]);
//
//// for UTC
// const utc = d3.scaleUtc();

public struct TimeScale: Scale {
    public let isClamped: Bool
    public let domain: ClosedRange<Date>
    public let range: ClosedRange<CGFloat>

    init(domain: ClosedRange<Date>, range: ClosedRange<CGFloat>, isClamped: Bool = false) {
        self.isClamped = isClamped
        self.domain = domain
        self.range = range
    }

    /// scales the input value (within domain) per the scale to the relevant output (using range)
    ///
    /// - Parameter x: value within the domain
    /// - Returns: scaled value
    public func scale(_ inputValue: Date) -> CGFloat {
        return 0.0
        // interpolate(normalize(inputValue, domain: domain), range: range)
    }

    public func invert(_ outputValue: CGFloat) -> Date {
        return Date()
        // interpolate(normalize(outputValue, domain: range), range: domain)
    }

    /// returns an array of the locations of ticks
    ///
    /// - Parameter count: number of steps to take in the ticks, default of 10
    /// - Returns: array of the locations of the ticks within self.range
    public func ticks(count: Int = 10) -> [CGFloat] {
        var result: [CGFloat] = Array()
        for _ in stride(from: 0, through: count, by: 1) {
            result.append(0.0) // interpolate(Double(i) / Double(count), range: domain))
        }
        return result
    }
}
