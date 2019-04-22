//
//  Scatterplot.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

/*
 So my hypothetical 3d-viz for an equiv of a scatterplot:

 --+ root SCNNode
 |
 +- xAxis
 +- yAxis
 +- plotPlane
 +- legend

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

 Interaction components:
  - camera (expected to be defined prior to scene element generation)
  - let hitResults = sceneView.hitTest(locationInView(SKview), options: nil)

 external the this setup
 - lighting
 - maybe a floor

 */

public class ScatterPlot: SCNNode {
    private let x: String

    // xAxis (opt)
    // yAxis (opt)
    // zAxis (opt)

    // DataSpace
    //  - dataSource
    // options for presenting data:
    // - start w/ collection, hand in a closure to return data values for specific axis
    //   - hand in 1, 2, or 3 values depending on the type of scattering you want
    //   - hand back a datapoint for each index/count and then get X, Y, Z (and anything else) from
    //     that data object
    // - format the data such that you can iterate through the data source methods to get the
    //   values you want.

    // IOSCharts has a concept of "datasets" - and a single chart can have multiple of them displayed
    // in a single view. That sort of matches (more closely anyway) this datasource concept - only there
    // are multiple data sources for a single plot.

    // D3 inverts this whole process, and leaves the data collection and selection up to you, having
    // you construct methods that end with get invoked around/through enter() and exit().

    // Legend (opt)
    // Title (opt)

    public init(x: String) {
        self.x = x
        super.init()

        // add children to render the scene as needed
    }

    // func addAxis() - provide a scale & domain, and direction
    // need to know which data point to use for the relevant axis value
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
