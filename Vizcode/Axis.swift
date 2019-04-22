//
//  Axis.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/19/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

/*
 Axis - a visual representation
 built on a scale
 specific to a dimension (x, y, or z)
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

public enum AxisDirection {
    case x
    case y
    case z
}

public class Axis: SCNNode {
    // NOTE(heckj): figure out how to reframe this in terms of a generic "Scale",
    // (which is a protocol with an associated type) so we could theoretically use
    // a TimeScale here instead of LinearScale - or infer it from the initializer.
    public let internalScale: LinearScale
    public let direction: AxisDirection

    public init(scale: LinearScale, direction: AxisDirection) {
        internalScale = scale
        self.direction = direction
        super.init()

        // add children to render the scene as needed
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // use internalScale.ticks() to determine location for ticks
    // represent them with capsules, or maybe thin "boxes" aligned to the axis?
}
