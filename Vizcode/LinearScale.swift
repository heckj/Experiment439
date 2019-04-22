//
//  LinearScale.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/22/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation

public struct LinearScale: Scale {
    public let isClamped: Bool
    public let domain: Range<Double>
    public let range: Range<Double>

    init(domain: Range<Double>, range: Range<Double>, isClamped: Bool) {
        self.isClamped = isClamped
        self.domain = domain
        self.range = range
    }

    /// scales the input value (within domain) per the scale to the relevant output (using range)
    ///
    /// - Parameter x: value within the domain
    /// - Returns: scaled value
    public func scale(_ inputValue: Double) -> Double {
        return interpolate(normalize(inputValue, domain: domain), range: range)
    }

    public func invert(_ outputValue: Double) -> Double {
        return interpolate(normalize(outputValue, domain: range), range: domain)
    }

    /// returns an array of the locations of ticks
    ///
    /// - Parameter count: number of steps to take in the ticks, default of 10
    /// - Returns: array of the locations of the ticks within self.range
    public func ticks(count: Int = 10) -> [Double] {
        var result: [Double] = Array()
        for i in stride(from: 0, through: count, by: 1) {
            result.append(interpolate(Double(i) / Double(count), range: domain))
        }
        return result
    }
}
