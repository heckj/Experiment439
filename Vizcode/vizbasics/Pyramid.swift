//
//  Pyramid.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

class Pyramid: SCNNode {
    init(radius: CGFloat = 1.0, color: NSColor) {
        super.init()

        geometry = SCNPyramid()
        // init(width: CGFloat, height: CGFloat, length: CGFloat)

        let material = SCNMaterial()
        material.diffuse.contents = color
        geometry?.firstMaterial = material
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Sphere Node Coder Not Implemented") }
}
