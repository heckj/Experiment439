//
//  Scale.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/19/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation

/// Inspired by D3's scale concept - maps input values (domain) to an output range (range)
/// - https://github.com/d3/d3-scale
/// - https://github.com/pshrmn/notes/blob/master/d3/scales.md

// defining the protocol for this, using Protocols and Associated Types
// This is kind of confusing if you've not been down that road, and there's a pretty
// good article on it at
// https://www.hackingwithswift.com/articles/74/understanding-protocol-associated-types-and-their-constraints

public protocol Scale {
    associatedtype ComparableType: Comparable

    var isClamped: Bool { get }
    var domain: Range<ComparableType> { get }
    var range: Range<ComparableType> { get }

//    func init(domain: Range<ComparableType>, range: Range<ComparableType>, isClamped: Bool)
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

// MARK: - general functions used in various implementations of Scale

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
