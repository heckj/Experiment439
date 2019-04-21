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

    // func ticks() uses internalScale.ticks to determine location for ticks
}

/*
 I'm thinking that I want to do something like:

 myScene = SCNView
 myScene.rootNode.addChildNode(xAxis.node)

 I guess the question is - if I change the Axis object, do I want to automatically propogate those
 model changes into the Node hierarchy? For example, does it act like a controller in an MVC kind
 of context?

 if something acts as a controller, we probably want it to be a class (?maybe? not sure of
 tradeoffs there) and have it keep references to the SCNNodes that it's both rendered and is
 twiddling/changing. The SCNNode sort of being the moral equivalent of the "view" in a
 ViewController. That includes removing and add nodes from the hierarchy under which it sets, and
 I guess "knowing" when it needs to do so based on method calls/data changes.

 So my hypothetical 3d-viz for an equiv of a scatterplot:

 --+ root SCNNode
   |
   +- xAxis
   +- yAxis
   +- plotPlane
   +- legend

 viewControllers update what's presented through interaction feedback or when getting new data,
 and then it does a reloadData or insert/remove|data call - more often reload triggers the dataSource
 delegate methods, so the dataSource can answer questions about itself as the view needs.

 So maybe we start with computed properties of Axis to generate SCNNode classes on request/demand, but
 don't keep any references to existing SCNNodes for updating - separating concerns for generating and
 updating, at least to start...

 call it a xxxCoordinator
  - subclass SCNNode
  - applies material, sizes, maybe even locates/transforms
  - init() creates it's own children nodes as needed

  - ScatterViz
    +- xAxis
    +- yAxis
    +- zAxis
    +- Legend
    +- Title
    +- DataView
 DataView.init()? sets up delegate/data source?
 - reloadView()
 - addData() (if you know diff)
 - removeData() (if you know diff)

 DataSource:
  - count
  - dataAtIndex
 maybe some binding to each access in DataSource ref - closures that will provide the answer?
 (sorted? ordered data for enumeration?)

 collection subtype - some way to say "iterate over axis X, get Y (and maybe Z) values"

 */
