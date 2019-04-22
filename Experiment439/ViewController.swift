//
//  ViewController.swift
//  Experiment439
//
//  Created by Joseph Heck on 4/18/19.
//  Copyright © 2019 BackDrop. All rights reserved.
//

import Cocoa
import SceneKit

class ViewController: NSViewController {
    @IBOutlet private var textview: NSTextView!
    @IBOutlet private var scenekitview: SCNView!

    // example definitions to work through reality of SceneKit things
    // https://code.tutsplus.com/tutorials/an-introduction-to-scenekit-user-interaction-animations-physics--cms-23877
    var camera: SCNNode!
    var ground: SCNNode!
    var light: SCNNode!
    var button: SCNNode!
    var sphere1: SCNNode!
    var sphere2: SCNNode!

    // swiftlint:disable:next function_body_length
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.textStorage?.append(NSAttributedString(string: "viewDidLoad()"))

        // Do any additional setup after loading the view.

        // initialize the scene (empty)
        scenekitview.scene = SCNScene()

        let groundGeometry = SCNFloor()
        groundGeometry.reflectivity = 0
        let groundMaterial = SCNMaterial()
        groundMaterial.diffuse.contents = NSColor.blue
        groundGeometry.materials = [groundMaterial]
        ground = SCNNode(geometry: groundGeometry)

        let camera = SCNCamera()
        camera.zFar = 10000
        self.camera = SCNNode()
        self.camera.camera = camera
        self.camera.position = SCNVector3(x: -20, y: 15, z: 20)
        let constraint = SCNLookAtConstraint(target: ground)
        constraint.isGimbalLockEnabled = true
        self.camera.constraints = [constraint]

        let ambientLight = SCNLight()
        ambientLight.color = NSColor.darkGray
        ambientLight.type = SCNLight.LightType.ambient
        self.camera.light = ambientLight

        let spotLight = SCNLight()
        spotLight.type = SCNLight.LightType.spot
        spotLight.castsShadow = true
        spotLight.spotInnerAngle = 70.0
        spotLight.spotOuterAngle = 90.0
        spotLight.zFar = 500
        light = SCNNode()
        light.light = spotLight
        light.position = SCNVector3(x: 0, y: 25, z: 25)
        light.constraints = [constraint]

        let sphereGeometry = SCNSphere(radius: 1.5)
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = NSColor.green
        sphereGeometry.materials = [sphereMaterial]
        sphere1 = SCNNode(geometry: sphereGeometry)
        sphere1.position = SCNVector3(x: -15, y: 1.5, z: 0)
        sphere2 = SCNNode(geometry: sphereGeometry)
        sphere2.position = SCNVector3(x: 15, y: 1.5, z: 0)

        let buttonGeometry = SCNBox(width: 4, height: 1, length: 4, chamferRadius: 0)
        let buttonMaterial = SCNMaterial()
        buttonMaterial.diffuse.contents = NSColor.red
        buttonGeometry.materials = [buttonMaterial]
        button = SCNNode(geometry: buttonGeometry)
        button.position = SCNVector3(x: 0, y: 0.5, z: 15)

        scenekitview.scene?.rootNode.addChildNode(self.camera)
        scenekitview.scene?.rootNode.addChildNode(ground)
        scenekitview.scene?.rootNode.addChildNode(light)
        scenekitview.scene?.rootNode.addChildNode(button)
        scenekitview.scene?.rootNode.addChildNode(sphere1)
        scenekitview.scene?.rootNode.addChildNode(sphere2)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
