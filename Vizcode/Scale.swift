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
/// https://github.com/pshrmn/notes/blob/master/d3/scales.md

// defining the protocol for this, using Protocols and Associated Types
// kind of confusing if you've not been down that road, and there's a pretty good article
// on it at https://www.hackingwithswift.com/articles/74/understanding-protocol-associated-types-and-their-constraints

public protocol Scale {
    associatedtype ComparableType: Comparable

    var isClamped: Bool { get }
    var domain: Range<ComparableType> { get }
    var range: Range<ComparableType> { get }

    func scale(_ inputValue: ComparableType) -> ComparableType
    func invert(_ outputValue: ComparableType) -> ComparableType
    func ticks(count: Int) -> [ComparableType]
}

// NOTE(heckj): OTHER SCALES: make a PowScale (& maybe Sqrt, Log, Ln)

// Quantize scale: Quantize scales use a discrete range and a continuous domain.
//   Range mapping is done by dividing the domain domain evenly by the number of elements
//   in the range. Because the range is discrete, the values do not have to be numbers.

// Quantile scale: Quantile scales are similar to quantize scales, but instead of evenly
//   dividing the domain, they determine threshold values based on the domain that are
//   used as the cutoffs between values in the range.
//   Quantile scales take an array of values for a domain (not just a lower and upper limit)
//   and maps range to be an even distribution over the input domain

// Threshold Scale

// Time Scale
// - https://github.com/d3/d3-scale/blob/master/src/time.js
// - D3 has a time format (https://github.com/d3/d3-time-format), but we can probably use
//   IOS/MacOS NSTime, NSDate formatters and calendrical mechanisms

// Ordinal Scale
// Band Scale
// Point Scale

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
