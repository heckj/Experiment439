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

    init(domain: Range<Double>, range: Range<Double>, isClamped: Bool) {
        self.isClamped = isClamped
    }
}

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

 Axis - a visual representation
 built on a scale
 often specific to a dimension (x, y, or z)
 draws the ticks, numbers the line, etc for a side of a chart
 • axisBottom(scale)
 • axisTop(scale)
 • axisLeft(scale)
 • axisRight(scale)
 • axis.ticks(count) passes down to scale.domain...
 • or axis.ticks(d3.timeMinute.every(15)) to create a tick every 15 min
 • ticks have a size - both inner and outer
 often has a margin (spacing) and translation from the side it's attached
 */
