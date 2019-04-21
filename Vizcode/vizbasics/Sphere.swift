//
//  Sphere.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/21/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

class Sphere: SCNNode {
    /// Creates An SCNSphere With a Single Color for its material
    /// - Parameters:
    ///  - radius: Optional CGFloat (Defaults To 30cm)
    /// - color: UIColor
    init(radius: CGFloat = 1.0, color: NSColor) {
        super.init()

        // 1. Create The Sphere Geometry With Our Radius Parameter
        geometry = SCNSphere(radius: radius)

        // 2. Create A New Material
        let material = SCNMaterial()

        // 3. The Material Will Be A UIColor
        material.diffuse.contents = color

        // 4. Set The Material Of The Sphere
        geometry?.firstMaterial = material
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Sphere Node Coder Not Implemented") }
}
