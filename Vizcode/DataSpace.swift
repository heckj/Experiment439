//
//  DataSpace.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

public protocol DataItemValueProvider {
    func xValue(_ datapoint: Any) -> Double
    func yValue(_ datapoint: Any) -> Double
    func zValue(_ datapoint: Any) -> Double
}

public protocol DataSpaceDataSource: NSObjectProtocol {
    func numberOfItems(for dataSpace: DataSpace) -> Int
    func dataPoint(_ dataSpace: DataSpace, ItemAt index: Int) -> DataItemValueProvider
}

public class DataSpace: SCNNode {
    private let x: Int // need to add some sort of delegate
    public let datasource: DataSpaceDataSource?

    public init(x: Int) {
        self.x = x
        datasource = nil
        super.init()

        // add children to render the scene as needed
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadData() {}
    func addData() {}
    func removeData() {}
}
