//
//  Scale.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/19/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation

// inspiration from https://github.com/d3/d3-scale
// reference on Range: https://developer.apple.com/documentation/swift/range

/*
 Scale
 has a "domain" which is covering what will be displayed (aka 0% to 100%) (input concept)
 has a "range" that which it maps the domain to in the visual presentation (0,400px) (output concept)
 has a type "ScaleLinear"
 • linear
 ◦ special linear scale for Time as well
 • identity (1:1)
 • Power & Log (sqrt, pow, log, ln)
 • Quantize and Quantile
 • Ordinal
 continuous, invert, and tick - functions
 can clamp or round values
 • tick computes values from the domain
 ◦ .ticks([count])
 ◦ .tickFormat([count [, specifier]])
 • may specify an interpolator (for choosing color - such as HCL or CubeHelix)
 ◦ There's a whole subclass of tech here in D3 - d3.color
 ‣ cubehelix (https://github.com/d3/d3-color/blob/master/src/cubehelix.js)
 ‣ hcl
 ‣ lab
 */

/// Inspired by D3's scale concept - maps input values (domain) to an output range (range)
public struct Scale<T: Comparable> {
    /// input values for the scale
    public let domain: Range<T>
    /// the output values possible for the scale
    public let range: Range<T>
    /// should the input values be clamped to the edges of the domain
    public let clamp = false
}

public struct LinearScale {
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
    func scale(_ inputValue: Double) -> Double {
        return interpolate(normalize(inputValue, domain: domain), range: range)
    }

    /// returns an array of the locations of ticks
    ///
    /// - Parameter count: number of steps to take in the ticks, default of 10
    /// - Returns: array of the locations of the ticks within self.range
    func ticks(count: Int = 10) -> [Double] {
        var result: [Double] = Array()
        for i in stride(from: 0, through: count, by: 1) {
            print(i) // prints 0 to 10
            result.append(interpolate(Double(i) / Double(count), range: domain))
        }
        return result
    }
}

/// normalize(a, b)(x) takes a domain value x in [a,b] and returns the corresponding parameter t in [0,1].
func normalize(_ x: Double, domain: Range<Double>) -> Double {
    if domain.contains(x) {
        let overallDistance = domain.upperBound - domain.lowerBound
        let foo = (x - domain.lowerBound) / overallDistance
        return foo
    }
    return Double.nan
}

// inspiration - https://github.com/d3/d3-interpolate#interpolateNumber
/// interpolate(a, b)(t) takes a parameter t in [0,1] and returns the corresponding range value x in [a,b].
func interpolate(_ x: Double, range: Range<Double>) -> Double {
    return range.lowerBound * (1 - x) + range.upperBound * x
}
