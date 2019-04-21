//
//  Tube.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

class Tube: SCNNode {
    init(innerRadius: CGFloat = 0.5, outerRadius: CGFloat = 1.0, height: CGFloat = 1.0, color: NSColor) {
        super.init()

        geometry = SCNTube(innerRadius: innerRadius, outerRadius: outerRadius, height: height)

        let material = SCNMaterial()
        material.diffuse.contents = color
        geometry?.firstMaterial = material
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Sphere Node Coder Not Implemented") }
}
