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

    override func viewDidLoad() {
        super.viewDidLoad()
        textview.textStorage?.append(NSAttributedString(string: "viewDidLoad()"))

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
