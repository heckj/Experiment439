//
//  Barplot.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

public class BarPlot: SCNNode {
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
