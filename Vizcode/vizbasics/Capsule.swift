//
//  Capsule.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

class Capsule: SCNNode {
    init(capRadius: CGFloat = 1.0, height: CGFloat = 1.0, color: NSColor) {
        super.init()

        geometry = SCNCapsule(capRadius: capRadius, height: height)
        // init(capRadius: CGFloat, height: CGFloat)

        let material = SCNMaterial()
        material.diffuse.contents = color
        geometry?.firstMaterial = material
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Sphere Node Coder Not Implemented") }
}
