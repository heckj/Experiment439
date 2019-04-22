//
//  DataSpace.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

public protocol DataPointValueProvider {
    // NOTE(heckj): these might make more sense as properties than functions...

    // x, y, z location seems relevant
    func xValue(_ datapoint: Any) -> CGFloat
    func yValue(_ datapoint: Any) -> CGFloat
    func zValue(_ datapoint: Any) -> CGFloat

    func node(_ datapoint: Any) -> SCNNode
    // includes:
    // - color/material
    // - shape
    // - size/scale adjustments
}

public protocol DataSpaceDataSource: NSObjectProtocol {
    func numberOfItems(for dataSpace: DataSpace) -> Int
    func dataPoint(_ dataSpace: DataSpace, ItemAt index: Int) -> DataPointValueProvider
}

public class DataSpace: SCNNode {
    private let x: Int // need to add some sort of delegate
    public let datasource: [DataSpaceDataSource]?

    public init(x: Int) {
        self.x = x
        datasource = nil
        super.init()

        // add children to render the scene as needed
        // we might also need references to one or more Axis objects, so that we can use
        // the included Scale's within them to determine location/translation within the plot -
        // morphing data returned from the struct/obj implementing DataSpaceDataSource protocol
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // ?
    func addDataSource(dsds: DataSpaceDataSource) {} // w/ Axis for the datasource?
    func removeDataSource(dsds: DataSpaceDataSource) {}

    func reloadData() {} // removes all existing nodes and re-creates them from datasource
    func addData() {} // add specific data nodes from datasource
    func removeData() {} // remove specific data nodes from datasource
}
