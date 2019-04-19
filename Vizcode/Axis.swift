//
//  Axis.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/19/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Foundation
import SceneKit

public enum AxisDirection {
    case x
    case y
    case z
}

public struct Axis {
    public let scale: LinearScale
    public let direction: AxisDirection
}

/*
 I'm thinking that I want to do something like:

 myScene = SCNView
 myScene.rootNode.addChildNode(xAxis.node)

 I guess the question is - if I change the Axis object, do I want to automatically propogate those
 model changes into the Node hierarchy? For example, does it act like a controller in an MVC kind
 of context?

 */
