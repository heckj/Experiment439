//
//  Box.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

class Box: SCNNode {
    init(width: CGFloat = 1.0,
         height: CGFloat = 1.0,
         length: CGFloat = 1.0,
         chamferRadius: CGFloat = 0.1,
         color: NSColor)
    {
        super.init()

        geometry = SCNBox(width: width, height: height, length: length, chamferRadius: chamferRadius)
        // init(width: CGFloat, height: CGFloat, length: CGFloat, chamferRadius: CGFloat)

        let material = SCNMaterial()
        material.diffuse.contents = color
        geometry?.firstMaterial = material
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Sphere Node Coder Not Implemented") }
}
