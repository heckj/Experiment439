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
 3d-viz for an equiv of a scatterplot:

 - subclass SCNNode
   - each SCNode has a frame of reference (position, scale, transform)
   - an SCNNode *may* also have geometry, and each geometry has it's own material
   - have the children node have the relevant geometry to make up the visual structures within
     the nodes general frame of reference
   - applies material, sizes, maybe even scale transforms
 - init() creates it's own children nodes as needed

 -+- ScatterViz (SCNNode)
  +- DataSpace (SCNNode + children) (need at least one axis defined...)
  +- Axis (Scale, Direction, SCNNode + children)
  +- yAxis (opt)
  +- zAxis (opt)
  +- Legend (opt) (SCNNode + children)
  +- Title (opt) (SCNNode + children)

 Interaction components:
  - camera (expected to be defined prior to scene element generation)
  - let hitResults = sceneView.hitTest(locationInView(SKview), options: nil)

 external the this setup
 - lighting
 - maybe a floor

 Using this stuff:
  - create a plot - maybe defining bounds in which you'd like to use it
  - create an Axis (with assocaited Scale) and add to the plot along with an associated DataSource
    - so you've got the thing providing the data (protocol enforced) and how to translate that
      into the bounds of the plot. The scale for the axis might infer a default vslue (or explicitly use
      the default value) of the bounds? Or maybe the bounds are defined by the Axis provided - which has
      a sort of length akin to it...

 api/dev usage ideas:

 1) create plot
   - used for overall placeholder and location/rotation tweaking - and to add everything (or
     incrementally add) data to the view/scene as you go. Maybe it also enables some "animation"
     of the data into place later...
 2) define an axis (or two) and add to plot
   - scale used for the Axis (req) - does the mapping for at least one dimension (incoming domain, outgoing range)
   - use axis->scale struct->range property to determine the "virtual size" of this space
 3) Add a datasource, along with a reference to at least one axis, to know how to plot it
   - I think we want to have a relation between axis and datasource (axis used to interp datasource data)
     but we probably want to allow all axis' to use a single data source
   - the reverse - adding multiple datasources, using the same axis, should plot parallel (or overlaid?) views, and would be how you create the layered views kind of setup
   - which properties (or func's) of the Datasource protocol get used will depend on the plot I expect

 */

public class ScatterPlot: SCNNode {
    private let x: String

    // xAxis (opt)
    // yAxis (opt)
    // zAxis (opt)

    // DataSpace
    //  - dataSource[]
    // options for presenting data:
    // - start w/ collection, hand in a closure to return data values for specific axis
    //   - hand in 1, 2, or 3 values depending on the type of scattering you want
    //   - hand back a datapoint for each index/count and then get X, Y, Z (and anything else) from
    //     that data object
    // - format the data such that you can iterate through the data source methods to get the
    //   values you want.
    // - when you add a DataSpace to a plot, you may also want to add it to the legend as well,
    //   optionally including a representative SCNNode if you want to distinguish based on shape/material

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
        // - add at least one axis (or start with an Axis in init)
        //   then add a DataSpace, referencing the Axis?
        // - optionally add a legend, maybe with a 3D Constraint to the scene's overall camera
        // - optionally add a title, maybe with a 3D Constraint to the scene's overall camera
    }

    // func addAxis() - provide a scale & domain, and direction
    // need to know which data point to use for the relevant axis value
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
