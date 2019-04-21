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

 */

public class ScatterPlot: SCNNode {
    private let x: String

    // xAxis (opt)
    // yAxis (opt)
    // zAxis (opt)
    // DataSpace
    //  - dataSource
    // Legend (opt)
    // Title (opt)

    public init(x: String) {
        self.x = x
        super.init()

        // add children to render the scene as needed
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
